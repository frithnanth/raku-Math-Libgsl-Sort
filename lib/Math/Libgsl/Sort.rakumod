use v6.c;

unit class Math::Libgsl::Sort:ver<0.0.2>:auth<zef:FRITH>;

use Math::Libgsl::Raw::Sort :ALL;
use Math::Libgsl::Vector;
use Math::Libgsl::Permutation;
use NativeCall;

# Sorting vectors
sub num64sort(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[num64] $d .= new: @data».Num;
  gsl_sort($d, $stride, ($d.list.elems / $stride).ceiling);
  $d.list
}

sub num64sort2(:@data1, Int :$stride1? = 1, :@data2, Int :$stride2? = 1 --> List) is export {
  my CArray[num64] $d1 .= new: @data1».Num;
  my CArray[num64] $d2 .= new: @data2».Num;
  gsl_sort2($d1, $stride1, $d2, $stride2, ($d1.list.elems / $stride1).ceiling);
  data1 => $d1.list, data2 => $d2.list
}

sub num64sort-index(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[num64] $d .= new: @data».Num;
  my size_t $n = ($d.list.elems / $stride).ceiling;
  my $p = CArray[size_t].allocate($n);
  gsl_sort_index($p, $d, $stride, $n);
  $p.list
}

sub num64sort-vector(Math::Libgsl::Vector $v) is export {
  gsl_sort_vector($v.vector)
}

sub num64sort2-vector(Math::Libgsl::Vector $v1, Math::Libgsl::Vector $v2) is export {
  gsl_sort_vector2($v1.vector, $v2.vector)
}

sub num64sort-vector-index(Math::Libgsl::Vector $v, Math::Libgsl::Permutation $p where $v.vector.size == *.p.size) is export {
  gsl_sort_vector_index($p.p, $v.vector)
}

# Selecting the k smallest or largest elements
sub num64smallest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num64] $src .= new: @data».Num;
  my $dst = CArray[num64].allocate: $k;
  gsl_sort_smallest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num64largest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num64] $src .= new: @data».Num;
  my $dst = CArray[num64].allocate: $k;
  gsl_sort_largest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num64smallest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num64] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_smallest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num64largest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num64] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_largest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num64vector-smallest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[num64].allocate: $k;
  gsl_sort_vector_smallest($dst, $k, $v.vector);
  $dst.list
}

sub num64vector-largest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[num64].allocate: $k;
  gsl_sort_vector_largest($dst, $k, $v.vector);
  $dst.list
}

sub num64vector-smallest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_vector_smallest_index($dst, $k, $v.vector);
  $dst.list
}

sub num64vector-largest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_vector_largest_index($dst, $k, $v.vector);
  $dst.list
}

=begin pod

=head1 NAME

Math::Libgsl::Sort - An interface to libgsl, the Gnu Scientific Library - Sort.

=head1 SYNOPSIS

=begin code :lang<raku>

use Math::Libgsl::Raw::Sort :ALL;

use Math::Libgsl::Sort;

=end code

=head1 DESCRIPTION

Math::Libgsl::Sort provides an interface to the sort functions of libgsl, the GNU Scientific Library.

This package provides both the low-level interface to the C library (Raw) and a more comfortable interface layer for the Raku programmer.

This package comes with the Sort module tailored to all the real and integer types:

=item Math::Libgsl::Sort              - default, corresponding to a Math::Libgsl::Sort::Num64
=item Math::Libgsl::Sort::Num32
=item Math::Libgsl::Sort::Int32
=item Math::Libgsl::Sort::UInt32
=item Math::Libgsl::Sort::Int64
=item Math::Libgsl::Sort::UInt64
=item Math::Libgsl::Sort::Int16
=item Math::Libgsl::Sort::UInt16
=item Math::Libgsl::Sort::Int8
=item Math::Libgsl::Sort::UInt8

All the subs of each package have their name prefixed by the relative data type:

Math::Libgsl::Sort has a sub num64sort, while Math::Libgsl::Sort::Int8 has a sub int8sort, and so on.

=head3 num64sort(:@data, Int :$stride? = 1 --> List)

This sub takes two named arguments: the data array and the stride. The sub returns a List of values: the element of the original array sorted in ascending order.

For example:

=begin code
my @data = (10…0)».Num;
say @data; # output: [10 9 8 7 6 5 4 3 2 1 0]
my @out = num64sort(:@data, :stride(2)); # sort the elements of @data, with a stride of 2: 10, 8, 6, 4, 2
say @out;  # output: [0 9 2 7 4 5 6 3 8 1 10]
=end code

=head3 num64sort2(:@data1, Int :$stride1? = 1, :@data2, Int :$stride2? = 1 --> List)

This sub takes four named arguments: two data arrays and the relative strides. The sub returns a List of Pairs: 'data1' and the element of the first array taken with a stride $stride1, sorted in ascending order, and 'data2' and the elements of the second array taken with a stride $stride2, rearranged as the first array.

For example:

=begin code
my @data1 = (10…0)».Num;
my @data2 = (20…0)».Num;
say @data1; # output: [10 9 8 7 6 5 4 3 2 1 0]
say @data2; # output: [20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0]
my %out = num64sort2(:@data1, :stride1(2), :@data2, :stride2(3));
say %out<data1>; # output: (0 9 2 7 4 5 6 3 8 1 10)
say %out<data2>; # output: (5 19 18 8 16 15 11 13 12 14 10 9 17 7 6 20 4 3 2 1 0)
=end code

=head3 num64sort-index(:@data, Int :$stride? = 1 --> List)

This sub indirectly sorts the elements of the array with stride into ascending order, returning the resulting permutation.

=head3 num64sort-vector(Math::Libgsl::Vector $v)

This sub sorts in place the elements of the Math::Libgsl::Vector $v into ascending numerical order.

=head3 num64sort2-vector(Math::Libgsl::Vector $v1, Math::Libgsl::Vector $v2)

This sub sorts the elements of the Math::Libgsl::Vector $v1 into ascending numerical order, while making the same rearrangement of the vector $v2.

=head3 num64sort-vector-index(Math::Libgsl::Vector $v, Math::Libgsl::Permutation $p where $v.vector.size == $p.p.size)

This sub indirectly sorts the elements of the Math::Libgsl::Vector $v, storing the resulting permutation in $p.
The vector and the permutation must have the same number of elements.

=head3 num64smallest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the $k smallest elements of the array, extracted with $stride, in ascending numerical order.

=head3 num64largest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the $k largest elements of the array, extracted with $stride, in ascending numerical order.

=head3 num64smallest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the indices of the $k smallest elements of the array, extracted with $stride, in ascending numerical order.

=head3 num64largest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List)

This sub returns the indices of the $k largest elements of the array, extracted with $stride, in ascending numerical order.

=head3 num64vector-smallest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the $k smallest elements of the vector, extracted with $stride, in ascending numerical order.

=head3 num64vector-largest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the $k largest elements of the vector, extracted with $stride, in ascending numerical order.

=head3 num64vector-smallest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the indices of the $k largest elements of the vector, extracted with $stride, in ascending numerical order.

=head3 num64vector-largest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List)

This sub returns the indices of the $k largest elements of the vector, extracted with $stride, in ascending numerical order.

=head1 C Library Documentation

For more details on libgsl see L<https://www.gnu.org/software/gsl/>.
The excellent C Library manual is available here L<https://www.gnu.org/software/gsl/doc/html/index.html>, or here L<https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf> in PDF format.

=head1 Prerequisites

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

=head2 Debian Linux and Ubuntu 20.04+

=begin code
sudo apt install libgsl23 libgsl-dev libgslcblas0
=end code

That command will install libgslcblas0 as well, since it's used by the GSL.

=head2 Ubuntu 18.04

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04.
I solved the issue installing the Debian Buster version of those three libraries:

=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb>

=head1 Installation

To install it using zef (a module management tool):

=begin code
$ zef install Math::Libgsl::Sort
=end code

=head1 AUTHOR

Fernando Santagata <nando.santagata@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
