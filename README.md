[![Actions Status](https://github.com/frithnanth/raku-Math-Libgsl-Sort/workflows/test/badge.svg)](https://github.com/frithnanth/raku-Math-Libgsl-Sort/actions)

NAME
====

Math::Libgsl::Sort - An interface to libgsl, the Gnu Scientific Library - Sort.

SYNOPSIS
========

```raku
use Math::Libgsl::Raw::Sort :ALL;

use Math::Libgsl::Sort;
```

DESCRIPTION
===========

Math::Libgsl::Sort provides an interface to the sort functions of libgsl, the GNU Scientific Library.

This package provides both the low-level interface to the C library (Raw) and a more comfortable interface layer for the Raku programmer.

This package comes with the Sort module tailored to all the real and integer types:

  * Math::Libgsl::Sort - default, corresponding to a Math::Libgsl::Sort::Num64

  * Math::Libgsl::Sort::Num32

  * Math::Libgsl::Sort::Int32

  * Math::Libgsl::Sort::UInt32

  * Math::Libgsl::Sort::Int64

  * Math::Libgsl::Sort::UInt64

  * Math::Libgsl::Sort::Int16

  * Math::Libgsl::Sort::UInt16

  * Math::Libgsl::Sort::Int8

  * Math::Libgsl::Sort::UInt8

All the subs of each package have their name prefixed by the relative data type:

Math::Libgsl::Sort has a sub num64sort, while Math::Libgsl::Sort::Int8 has a sub int8sort, and so on.

### num64sort(:@data, Int :$stride? = 1 --> List)

This sub takes two named arguments: the data array and the stride. The sub returns a List of values: the element of the original array sorted in ascending order.

For example:

    my @data = (10…0)».Num;
    say @data; # output: [10 9 8 7 6 5 4 3 2 1 0]
    my @out = num64sort(:@data, :stride(2)); # sort the elements of @data, with a stride of 2: 10, 8, 6, 4, 2
    say @out;  # output: [0 9 2 7 4 5 6 3 8 1 10]

### num64sort2(:@data1, Int :$stride1? = 1, :@data2, Int :$stride2? = 1 --> List)

This sub takes four named arguments: two data arrays and the relative strides. The sub returns a List of Pairs: 'data1' and the element of the first array taken with a stride $stride1, sorted in ascending order, and 'data2' and the elements of the second array taken with a stride $stride2, rearranged as the first array.

For example:

    my @data1 = (10…0)».Num;
    my @data2 = (20…0)».Num;
    say @data1; # output: [10 9 8 7 6 5 4 3 2 1 0]
    say @data2; # output: [20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0]
    my %out = num64sort2(:@data1, :stride1(2), :@data2, :stride2(3));
    say %out<data1>; # output: (0 9 2 7 4 5 6 3 8 1 10)
    say %out<data2>; # output: (5 19 18 8 16 15 11 13 12 14 10 9 17 7 6 20 4 3 2 1 0)

### num64sort-index(:@data, Int :$stride? = 1 --> List)

This sub indirectly sorts the elements of the array with stride into ascending order, returning the resulting permutation.

### num64sort-vector(Math::Libgsl::Vector $v)

This sub sorts in place the elements of the Math::Libgsl::Vector $v into ascending numerical order.

### num64sort2-vector(Math::Libgsl::Vector $v1, Math::Libgsl::Vector $v2)

This sub sorts the elements of the Math::Libgsl::Vector $v1 into ascending numerical order, while making the same rearrangement of the vector $v2.

### num64sort-vector-index(Math::Libgsl::Vector $v, Math::Libgsl::Permutation $p where $v.vector.size == $p.p.size)

This sub indirectly sorts the elements of the Math::Libgsl::Vector $v, storing the resulting permutation in $p. The vector and the permutation must have the same number of elements.

### num64smallest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the $k smallest elements of the array, extracted with $stride, in ascending numerical order.

### num64largest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the $k largest elements of the array, extracted with $stride, in ascending numerical order.

### num64smallest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the indices of the $k smallest elements of the array, extracted with $stride, in ascending numerical order.

### num64largest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the indices of the $k largest elements of the array, extracted with $stride, in ascending numerical order.

### num64vector-smallest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the $k smallest elements of the vector, extracted with $stride, in ascending numerical order.

### num64vector-largest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the $k largest elements of the vector, extracted with $stride, in ascending numerical order.

### num64vector-smallest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the indices of the $k largest elements of the vector, extracted with $stride, in ascending numerical order.

### num64vector-largest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the indices of the $k largest elements of the vector, extracted with $stride, in ascending numerical order.

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/). The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux and Ubuntu 20.04+
------------------------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04
------------

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04. I solved the issue installing the Debian Buster version of those three libraries:

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb)

Installation
============

To install it using zef (a module management tool):

    $ zef install Math::Libgsl::Sort

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

