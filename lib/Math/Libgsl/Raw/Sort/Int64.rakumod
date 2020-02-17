use v6;

unit module Math::Libgsl::Raw::Sort::Int64:ver<0.0.2>:auth<cpan:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::Matrix :ALL;
use Math::Libgsl::Raw::Permutation :ALL;

constant LIB  = ('gsl', v23);

# Sort::Int64ing vectors
sub gsl_sort_long(CArray[int64] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_long2(CArray[int64] $data1, size_t $stride1, CArray[int64] $data2, size_t $stride2, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_long_index(CArray[size_t] $p, CArray[int64] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_long_vector(gsl_vector $v) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_long_vector2(gsl_vector $v1, gsl_vector $v2) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_long_vector_index(gsl_permutation $p, gsl_vector $v) is native(LIB) is export(:sortvector) { * }
# Selecting the k smallest or largest elements
sub gsl_sort_long_smallest(CArray[int64] $dest, size_t $k, CArray[int64] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_long_largest(CArray[int64] $dest, size_t $k, CArray[int64] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_long_vector_smallest(CArray[int64] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_long_vector_largest(CArray[int64] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_long_smallest_index(CArray[size_t] $p, size_t $k, CArray[int64] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_long_largest_index(CArray[size_t] $p, size_t $k, CArray[int64] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_long_vector_smallest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_long_vector_largest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
