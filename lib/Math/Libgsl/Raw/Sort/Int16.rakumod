use v6;

unit module Math::Libgsl::Raw::Sort::Int16:ver<0.0.1>:auth<cpan:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::Matrix :ALL;
use Math::Libgsl::Raw::Permutation :ALL;

constant LIB  = ('gsl', v23);

# Sort::Int16ing vectors
sub gsl_sort_short(CArray[int16] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_short2(CArray[int16] $data1, size_t $stride1, CArray[int16] $data2, size_t $stride2, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_short_index(CArray[size_t] $p, CArray[int16] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_short_vector(gsl_vector $v) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_short_vector2(gsl_vector $v1, gsl_vector $v2) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_short_vector_index(gsl_permutation $p, gsl_vector $v) is native(LIB) is export(:sortvector) { * }
# Selecting the k smallest or largest elements
sub gsl_sort_short_smallest(CArray[int16] $dest, size_t $k, CArray[int16] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_short_largest(CArray[int16] $dest, size_t $k, CArray[int16] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_short_vector_smallest(CArray[int16] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_short_vector_largest(CArray[int16] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_short_smallest_index(CArray[size_t] $p, size_t $k, CArray[int16] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_short_largest_index(CArray[size_t] $p, size_t $k, CArray[int16] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_short_vector_smallest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_short_vector_largest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
