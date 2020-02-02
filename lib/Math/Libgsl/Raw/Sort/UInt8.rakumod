use v6;

unit module Math::Libgsl::Raw::Sort::UInt8:ver<0.0.1>:auth<cpan:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::Matrix :ALL;
use Math::Libgsl::Raw::Permutation :ALL;

constant LIB  = ('gsl', v23);

# Sort::Uint8ing vectors
sub gsl_sort_uchar(CArray[uint8] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_uchar2(CArray[uint8] $data1, size_t $stride1, CArray[uint8] $data2, size_t $stride2, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_uchar_index(CArray[size_t] $p, CArray[uint8] $data, size_t $stride, size_t $n) is native(LIB) is export(:sortarray) { * }
sub gsl_sort_uchar_vector(gsl_vector $v) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_uchar_vector2(gsl_vector $v1, gsl_vector $v2) is native(LIB) is export(:sortvector) { * }
sub gsl_sort_uchar_vector_index(gsl_permutation $p, gsl_vector $v) is native(LIB) is export(:sortvector) { * }
# Selecting the k smallest or largest elements
sub gsl_sort_uchar_smallest(CArray[uint8] $dest, size_t $k, CArray[uint8] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uchar_largest(CArray[uint8] $dest, size_t $k, CArray[uint8] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uchar_vector_smallest(CArray[uint8] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_uchar_vector_largest(CArray[uint8] $dest, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_uchar_smallest_index(CArray[size_t] $p, size_t $k, CArray[uint8] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uchar_largest_index(CArray[size_t] $p, size_t $k, CArray[uint8] $src, size_t $stride, size_t $n) is native(LIB) is export(:selectarray) { * }
sub gsl_sort_uchar_vector_smallest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
sub gsl_sort_uchar_vector_largest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(LIB) is export(:selectvector) { * }
