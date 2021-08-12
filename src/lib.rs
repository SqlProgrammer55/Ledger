use rand::prelude::*;
use std::borrow::Cow;
use std::error::Error;
use std::fs::File;
use std::io::{BufRead, BufReader};
use strong_xml::{XmlRead, XmlWrite};

use std::path::PathBuf;
use structopt::StructOpt;

use quick_xml::events::Event;
use quick_xml::{Reader, Writer};

#[derive(Debug, StructOpt)]
#[structopt(
    name = "TX Generator",
    about = "Generates dummy transaction data in XML"
)]
pub struct Cli {
    #[structopt(short, default_value = "100")]
    quantity: u32,
    #[structopt(short, default_value = "./accounts.txt")]
    accounts: PathBuf,
    #[structopt(short, default_value = "./tellers.txt")]
    tellers: PathBuf,
    #[structopt(short, default_value = "./products.txt")]
    products: PathBuf,
    #[structopt(short("y"), default_value = "./types.txt")]
    types: PathBuf,
    #[structopt(short, default_value = "./branches.txt")]
    branches: PathBuf,
}

impl Cli {
    pub fn quantity(&self) -> u32 {
        self.quantity
    }
}

fn get_lines_from_file(filename: &PathBuf) -> Result<Vec<String>, Box<dyn Error>> {
    // println!("reading input file {}", filename);

    let file = File::open(filename)?;

    let lines: Result<Vec<String>, std::io::Error> = BufReader::new(file).lines().collect();

    match lines {
        Ok(lines) => return Ok(lines),
        Err(why) => return Err(Box::new(why)),
    }
}

pub struct DataProvider {
    accounts: Vec<String>,
    tellers: Vec<String>,
    products: Vec<String>,
    types: Vec<String>,
    branches: Vec<String>,
}

impl DataProvider {
    pub fn new(args: &Cli) -> Result<Self, Box<dyn Error>> {
        Ok(DataProvider {
            accounts: get_lines_from_file(&args.accounts)?,
            tellers: get_lines_from_file(&args.tellers)?,
            products: get_lines_from_file(&args.products)?,
            types: get_lines_from_file(&args.types)?,
            branches: get_lines_from_file(&args.branches)?,
        })
    }

    fn select_random<'a>(&self, data: &'a Vec<String>) -> &'a str {
        let mut rng = rand::thread_rng();
        return data.choose(&mut rng).unwrap();
    }

    pub fn select_account(&self) -> &str {
        return self.select_random(&self.accounts);
    }

    pub fn select_teller(&self) -> &str {
        return self.select_random(&self.tellers);
    }

    pub fn select_product(&self) -> &str {
        return self.select_random(&self.products);
    }

    pub fn select_type(&self) -> &str {
        return self.select_random(&self.types);
    }

    pub fn select_branch(&self) -> &str {
        return self.select_random(&self.branches);
    }

    pub fn select_amount(&self) -> String {
        let mut rng = rand::thread_rng();
        return format!("{}.{:.2}", rng.gen::<u8>(), rng.gen_range(0..100));
    }
}

#[derive(XmlWrite, XmlRead, PartialEq, Debug)]
#[xml(tag = "transaction")]
pub struct Entity<'a> {
    #[xml(flatten_text = "AccountID")]
    pub account_id: Cow<'a, str>,
    #[xml(flatten_text = "Product")]
    pub account_type: Cow<'a, str>,
    #[xml(flatten_text = "Type")]
    pub transaction_type: Cow<'a, str>,
    #[xml(flatten_text = "Currency")]
    pub currency: Cow<'a, str>,
    #[xml(flatten_text = "Amount")]
    pub amount: Cow<'a, str>,
    #[xml(flatten_text = "Branch")]
    pub branch: Cow<'a, str>,
    #[xml(flatten_text = "TellerID")]
    pub teller_id: Cow<'a, str>,
}

pub fn generate<'a>(data_provider: &'a DataProvider) -> Entity<'a> {
    Entity {
        account_id: data_provider.select_account().into(),
        account_type: data_provider.select_product().into(),
        transaction_type: data_provider.select_type().into(),
        currency: "USD".into(),
        amount: data_provider.select_amount().into(),
        branch: data_provider.select_branch().into(),
        teller_id: data_provider.select_teller().into(),
    }
}

pub fn write(record: &Entity, filename: &str) -> Result<(), Box<dyn Error>> {
    // println!("Writing record {} with AccountID {}", index, record.account_id);

    // let mut file = File::create(filename)?;
    // let xml_as_string = record.to_string()?;
    // file.write_all(xml_as_string.as_bytes())?;

    let file = File::create(filename)?;
    let mut writer = Writer::new_with_indent(file, b' ', 2);

    let xml_as_string = record.to_string()?;
    let mut reader = Reader::from_str(&xml_as_string);
    reader.trim_text(true);

    let mut buf = Vec::new();
    loop {
        let read_result = match reader.read_event(&mut buf) {
            Ok(Event::Eof) => break,
            Ok(e) => writer.write_event(&e),
            Err(why) => return Err(Box::new(why)),
        };

        if let Err(why) = read_result {
            return Err(Box::new(why));
        }

        buf.clear();
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn original_converts_properly() {
        assert_eq!(
            (Entity {
                account_id: "X9S3R5RA".into(),
                account_type: "Draft Account".into(),
                transaction_type: "Deposit".into(),
                currency: "USD".into(),
                amount: "200".into(),
                branch: "AZ".into(),
                teller_id: "DY5N2MOP".into()
            })
            .to_string()
            .unwrap(),
            r#"<transaction><AccountID>X9S3R5RA</AccountID><Product>Draft Account</Product><Type>Deposit</Type><Currency>USD</Currency><Amount>200</Amount><Branch>AZ</Branch><TellerID>DY5N2MOP</TellerID></transaction>"#
        );
    }
}
