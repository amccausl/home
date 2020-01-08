
pub mod p1 {
  pub fn naive( limit: u32 ) -> u32 {
    let mut sum: u32 = 0;
    let mut i: u32 = 0;
    while i < limit - 1 {
      i = i + 1;
      if i % 3 == 0 || i % 5 == 0  {
        sum += i;
      }
    }
    return sum
  }

  // Use pythagoras partial sums formula
  fn partial_sum( n: u32 ) -> u32 {
    return n * ( n + 1 ) / 2;
  }

  pub fn run( upper_bound: u32 ) -> u32 {
    return 3 * partial_sum( upper_bound - 1 / 3 ) + 5 * partial_sum( upper_bound - 1 / 5 ) - 15 * partial_sum( upper_bound - 1 / 15 );
  }

  #[cfg(test)]
  mod tests {
    use super::*;

    #[test]
    fn naive_sample() {
      assert_eq!( 23, naive( 10 ) );
    }

    #[test]
    fn naive_solution() {
      assert_eq!( 233168, naive( 1000 ) );
    }

    #[test]
    fn run_sample() {
      assert_eq!( 23, run( 10 ) );
    }

    #[test]
    fn run_solution() {
      assert_eq!( 233168, run( 1000 ) );
    }
  }
}

pub mod p2 {
  pub fn run( limit: u32 ) -> u32 {
    let mut sum: u32 = 0;

    let mut i = 1;
    let mut j = 2;
    while j < limit {
      if j % 2 == 0 {
        sum += j;
      }
      std::mem::swap(&mut i, &mut j);
      j = i + j;
    }
    return sum;
  }

  #[cfg(test)]
  mod tests {
    use super::*;

    #[test]
    fn run_sample() {
      assert_eq!( 2 + 8 + 34, run( 100 ) );
    }

    #[test]
    fn run_solution() {
      assert_eq!( 4_613_732, run( 4_000_000 ) );
    }
  }
}
