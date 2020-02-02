use v6.c;

unit class Math::Libgsl::Sort::UInt32:ver<0.0.1>:auth<cpan:FRITH>;

use Math::Libgsl::Raw::Sort::UInt32 :ALL;
use Math::Libgsl::Vector;
use Math::Libgsl::Permutation;
use NativeCall;

# Sort::Uint32ing vectors
sub uint32sort(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[uint32] $d .= new: @data».Num;
  gsl_sort_uint($d, $stride, ($d.list.elems / $stride).ceiling);
  $d.list
}

sub uint32sort2(:@data1, Int :$stride1? = 1, :@data2, Int :$stride2? = 1 --> List) is export {
  my CArray[uint32] $d1 .= new: @data1».Num;
  my CArray[uint32] $d2 .= new: @data2».Num;
  gsl_sort_uint2($d1, $stride1, $d2, $stride2, ($d1.list.elems / $stride1).ceiling);
  out1 => $d1.list, out2 => $d2.list
}

sub uint32sort-index(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[uint32] $d .= new: @data».Num;
  my size_t $n = ($d.list.elems / $stride).ceiling;
  my $p = CArray[size_t].allocate($n);
  gsl_sort_uint_index($p, $d, $stride, $n);
  $p.list
}

sub uint32sort-vector(Math::Libgsl::Vector $v) is export {
  gsl_sort_uint_vector($v.vector)
}

sub uint32sort2-vector(Math::Libgsl::Vector $v1, Math::Libgsl::Vector $v2) is export {
  gsl_sort_uint_vector2($v1.vector, $v2.vector)
}

sub uint32sort-vector-index(Math::Libgsl::Vector $v, Math::Libgsl::Permutation $p where $v.vector.size == *.p.size) is export {
  gsl_sort_uint_vector_index($p.p, $v.vector)
}

# Selecting the k smallest or largest elements
sub uint32smallest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[uint32] $src .= new: @data».Num;
  my $dst = CArray[uint32].allocate: $k;
  gsl_sort_uint_smallest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub uint32largest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[uint32] $src .= new: @data».Num;
  my $dst = CArray[uint32].allocate: $k;
  gsl_sort_uint_largest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub uint32smallest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[uint32] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_uint_smallest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub uint32largest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[uint32] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_uint_largest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub uint32vector-smallest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[uint32].allocate: $k;
  gsl_sort_uint_vector_smallest($dst, $k, $v.vector);
  $dst.list
}

sub uint32vector-largest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[uint32].allocate: $k;
  gsl_sort_uint_vector_largest($dst, $k, $v.vector);
  $dst.list
}

sub uint32vector-smallest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_uint_vector_smallest_index($dst, $k, $v.vector);
  $dst.list
}

sub uint32vector-largest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_uint_vector_largest_index($dst, $k, $v.vector);
  $dst.list
}
