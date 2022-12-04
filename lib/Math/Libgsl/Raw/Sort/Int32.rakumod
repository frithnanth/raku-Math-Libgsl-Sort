use v6;

unit module Math::Libgsl::Raw::Sort::Int32:ver<0.0.3>:auth<zef:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::Matrix :ALL;
use Math::Libgsl::Raw::Permutation :ALL;

sub LIB {
  run('/sbin/ldconfig', '-p', :chomp, :out).out.slurp(:close).split("\n").grep(/^ \s+ libgsl\.so\. \d+ /).sort.head.comb(/\S+/).head;
}

# Sort::Int32ing vectors
sub gsl_sort_int(CArray[int32] $data, size_t $stride, size_t $n) is native(&LIB) is export(:sortarray) { * }
sub gsl_sort_int2(CArray[int32] $data1, size_t $stride1, CArray[int32] $data2, size_t $stride2, size_t $n) is native(&LIB) is export(:sortarray) { * }
sub gsl_sort_int_index(CArray[size_t] $p, CArray[int32] $data, size_t $stride, size_t $n) is native(&LIB) is export(:sortarray) { * }
sub gsl_sort_int_vector(gsl_vector $v) is native(&LIB) is export(:sortvector) { * }
sub gsl_sort_int_vector2(gsl_vector $v1, gsl_vector $v2) is native(&LIB) is export(:sortvector) { * }
sub gsl_sort_int_vector_index(gsl_permutation $p, gsl_vector $v) is native(&LIB) is export(:sortvector) { * }
# Selecting the k smallest or largest elements
sub gsl_sort_int_smallest(CArray[int32] $dest, size_t $k, CArray[int32] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_int_largest(CArray[int32] $dest, size_t $k, CArray[int32] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_int_vector_smallest(CArray[int32] $dest, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
sub gsl_sort_int_vector_largest(CArray[int32] $dest, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
sub gsl_sort_int_smallest_index(CArray[size_t] $p, size_t $k, CArray[int32] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_int_largest_index(CArray[size_t] $p, size_t $k, CArray[int32] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_int_vector_smallest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
sub gsl_sort_int_vector_largest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
