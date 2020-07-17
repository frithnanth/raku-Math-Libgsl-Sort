use v6;

unit module Math::Libgsl::Raw::Sort::UInt64:ver<0.0.2>:auth<cpan:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::Matrix :ALL;
use Math::Libgsl::Raw::Permutation :ALL;

sub LIB {
  run('/sbin/ldconfig', '-p', :chomp, :out).out.slurp(:close).split("\n").grep(/^ \s+ libgsl\.so\. \d+ /).sort.head.comb(/\S+/).head;
}

# Sort::Uint64ing vectors
sub gsl_sort_ulong(CArray[uint64] $data, size_t $stride, size_t $n) is native(&LIB) is export(:sortarray) { * }
sub gsl_sort_ulong2(CArray[uint64] $data1, size_t $stride1, CArray[uint64] $data2, size_t $stride2, size_t $n) is native(&LIB) is export(:sortarray) { * }
sub gsl_sort_ulong_index(CArray[size_t] $p, CArray[uint64] $data, size_t $stride, size_t $n) is native(&LIB) is export(:sortarray) { * }
sub gsl_sort_ulong_vector(gsl_vector $v) is native(&LIB) is export(:sortvector) { * }
sub gsl_sort_ulong_vector2(gsl_vector $v1, gsl_vector $v2) is native(&LIB) is export(:sortvector) { * }
sub gsl_sort_ulong_vector_index(gsl_permutation $p, gsl_vector $v) is native(&LIB) is export(:sortvector) { * }
# Selecting the k smallest or largest elements
sub gsl_sort_ulong_smallest(CArray[uint64] $dest, size_t $k, CArray[uint64] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_ulong_largest(CArray[uint64] $dest, size_t $k, CArray[uint64] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_ulong_vector_smallest(CArray[uint64] $dest, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
sub gsl_sort_ulong_vector_largest(CArray[uint64] $dest, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
sub gsl_sort_ulong_smallest_index(CArray[size_t] $p, size_t $k, CArray[uint64] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_ulong_largest_index(CArray[size_t] $p, size_t $k, CArray[uint64] $src, size_t $stride, size_t $n) is native(&LIB) is export(:selectarray) { * }
sub gsl_sort_ulong_vector_smallest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
sub gsl_sort_ulong_vector_largest_index(CArray[size_t] $p, size_t $k, gsl_vector $v) is native(&LIB) is export(:selectvector) { * }
