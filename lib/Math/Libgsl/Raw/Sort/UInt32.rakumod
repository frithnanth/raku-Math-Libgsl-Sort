use v6;

unit module Math::Libgsl::Raw::Sort::UInt32:ver<0.0.1>:auth<cpan:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::Matrix :ALL;
use Math::Libgsl::Raw::Permutation :ALL;

constant LIB  = ('gsl', v23);

# Sort::Uint32ing vectors
sub gsl_sort_uint(CArray[uint32] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_uint2(CArray[uint32] $data1, size_t $stride1, CArray[uint32] $data2, size_t $stride2, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_uint_index(CArray[size_t] $p, CArray[uint32] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_uint_vector(gsl_vector $v) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_uint_vector2(gsl_vector $v1, gsl_vector $v2) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_uint_vector_index(gsl_permutation $p, gsl_vector $v) is native(LIB) is export(:sortvector) { * }
# Selecting the k smallest or largest elements
sub gsl_sort_uint_smallest(CArray[uint32] $dest, size_t $k, CArray[uint32] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uint_largest(CArray[uint32] $dest, size_t $k, CArray[uint32] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uint_vector_smallest(CArray[uint32] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_uint_vector_largest(CArray[uint32] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_uint_smallest_index(CArray[size_t] $p, size_t $k, CArray[uint32] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uint_largest_index(CArray[size_t] $p, size_t $k, CArray[uint32] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uint_vector_smallest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_uint_vector_largest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
