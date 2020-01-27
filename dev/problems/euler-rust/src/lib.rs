
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

  // #[cfg(test)]
  // mod tests {
  //   use super::*;

  //   #[test]
  //   fn run_sample() {
  //     assert_eq!( 29, run( 13195 ) );
  //   }

  //   #[test]
  //   fn run_solution() {
  //     assert_eq!( 0, run( 600_851_475_143 ) );
  //   }
  // }
}

pub mod p5 {
  pub fn run( limit: u64 ) -> u64 {
    let mut product: u64 = 1;
    let mut factors = vec![];

    for x in 1..limit + 1 {
      let mut outstanding = x;
      for factor in &factors {
        if outstanding % factor == 0 {
          outstanding /= factor;
        }
      }
      if outstanding != 1 {
        factors.push( outstanding );
        product *= outstanding;
      }
    }
    return product;
  }

  #[cfg(test)]
  mod tests {
    use super::*;

    #[test]
    fn run_sample() {
      assert_eq!( 2520, run( 10 ) );
    }

    #[test]
    fn run_solution() {
      assert_eq!( 232_792_560, run( 20 ) );
    }
  }
}

pub mod p6 {
  pub fn run( limit: u64 ) -> u64 {
    let mut sum = 0;
    let mut square_sum = 0;
    for i in 1..limit + 1 {
      sum += i;
      square_sum += i * i;
    }
    return ( sum * sum ) - square_sum;
  }

  #[cfg(test)]
  mod tests {
    use super::*;

    #[test]
    fn run_sample() {
      assert_eq!( 2640, run( 10 ) );
    }

    #[test]
    fn run_solution() {
      assert_eq!( 25164150, run( 100 ) );
    }
  }
}

pub mod p9 {
  pub fn run( sum: u64 ) -> Option<u64> {
    for b in 2..sum / 2 {
      for a in (1..b).rev() {
        let c = sum - a - b;
        let c_sq = c * c;
        let ab_sq = a * a + b * b;
        if ab_sq == c_sq {
          return Some( a * b * c );
        }
        if ab_sq < c_sq {
          break;
        }
      }
    }
    return None
  }

  #[cfg(test)]
  mod tests {
    use super::*;

    #[test]
    fn run_sample() {
      assert_eq!( Some( 60 ), run( 12 ) );
    }

    #[test]
    fn run_solution() {
      assert_eq!( Some( 31_875_000 ), run( 1000 ) );
    }
  }
}
