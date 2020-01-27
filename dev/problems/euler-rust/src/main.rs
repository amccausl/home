
fn main() {
  println!( "P1: {}", euler::p1::run( 1_000 ) );
  println!( "P2: {}", euler::p2::run( 4_000_000 ) );
  println!( "P5: {}", euler::p5::run( 20 ) );
  println!( "P6: {}", euler::p6::run( 100 ) );
  if let Some( p9 ) = euler::p9::run( 1000 ) {
    println!( "P9: {}", p9 );
  }
}
