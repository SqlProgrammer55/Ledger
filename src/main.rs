use dummy_transactions::{generate, write, Cli, DataProvider};
use std::process;
use structopt::StructOpt;

fn main() {
    // parse program arguments
    let options = Cli::from_args();
    // println!("{:?}", options);

    // create item which will randomize provided data points
    let data_provider = DataProvider::new(&options).unwrap_or_else(|err| {
        eprintln!("Failed to generate data provider: {}", err);
        process::exit(1);
    });

    // generate desired records
    for n in 0..options.quantity() {
        let record = generate(&data_provider);
        let filename = format!("{}.xml", n + 1);

        if let Err(why) = write(&record, &filename) {
            eprintln!("Failed to write file {}: {}", filename, why);
        }
    }
}
