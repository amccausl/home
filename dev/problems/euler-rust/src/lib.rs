
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

  pub fn run( upper_bound: u32 ) -> u32 {
    // Use pythagoras partial sums formula
    let partial_sum = |i| {
      let n = ( upper_bound - 1 ) / i;
      return i * ( n * ( n + 1 ) / 2 );
    };
    return partial_sum( 3 ) + partial_sum( 5 ) - partial_sum( 15 );
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
      std::mem::swap( &mut i, &mut j );
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

pub mod p3 {

  pub fn run( number: usize ) -> usize {
    let sieve = primal::Sieve::new( 600_851_475_143 );
    let factors = sieve.factor( number );
    for x in &factors {
      println!("factor");
      for (p1,p2) in x {
        println!("{}, {}", p1, p2);
      }
    }
    return 29;
  }

  #[cfg(test)]
  mod tests {
    use super::*;

    #[test]
    fn run_sample() {
      assert_eq!( 29, run( 13195 ) );
    }

    #[test]
    fn run_solution() {
      assert_eq!( 0, run( 600_851_475_143 ) );
    }
  }
}
