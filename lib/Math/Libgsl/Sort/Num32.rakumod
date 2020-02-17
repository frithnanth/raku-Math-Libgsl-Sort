use v6.c;

unit class Math::Libgsl::Sort::Num32:ver<0.0.2>:auth<cpan:FRITH>;

use Math::Libgsl::Raw::Sort::Num32 :ALL;
use Math::Libgsl::Vector::Num32;
use Math::Libgsl::Permutation;
use NativeCall;

# Sorting vectors
sub num32sort(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[num32] $d .= new: @data».Num;
  gsl_sort_float($d, $stride, ($d.list.elems / $stride).ceiling);
  $d.list
}

sub num32sort2(:@data1, Int :$stride1? = 1, :@data2, Int :$stride2? = 1 --> List) is export {
  my CArray[num32] $d1 .= new: @data1».Num;
  my CArray[num32] $d2 .= new: @data2».Num;
  gsl_sort_float2($d1, $stride1, $d2, $stride2, ($d1.list.elems / $stride1).ceiling);
  out1 => $d1.list, out2 => $d2.list
}

sub num32sort-index(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[num32] $d .= new: @data».Num;
  my size_t $n = ($d.list.elems / $stride).ceiling;
  my $p = CArray[size_t].allocate($n);
  gsl_sort_float_index($p, $d, $stride, $n);
  $p.list
}

sub num32sort-vector(Math::Libgsl::Vector $v) is export {
  gsl_sort_float_vector($v.vector)
}

sub num32sort2-vector(Math::Libgsl::Vector $v1, Math::Libgsl::Vector $v2) is export {
  gsl_sort_float_vector2($v1.vector, $v2.vector)
}

sub num32sort-vector-index(Math::Libgsl::Vector $v, Math::Libgsl::Permutation $p where $v.vector.size == *.p.size) is export {
  gsl_sort_float_vector_index($p.p, $v.vector)
}

# Selecting the k smallest or largest elements
sub num32smallest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num32] $src .= new: @data».Num;
  my $dst = CArray[num32].allocate: $k;
  gsl_sort_float_smallest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num32largest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num32] $src .= new: @data».Num;
  my $dst = CArray[num32].allocate: $k;
  gsl_sort_float_largest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num32smallest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num32] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_float_smallest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num32largest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[num32] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_float_largest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub num32vector-smallest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[num32].allocate: $k;
  gsl_sort_float_vector_smallest($dst, $k, $v.vector);
  $dst.list
}

sub num32vector-largest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[num32].allocate: $k;
  gsl_sort_float_vector_largest($dst, $k, $v.vector);
  $dst.list
}

sub num32vector-smallest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_float_vector_smallest_index($dst, $k, $v.vector);
  $dst.list
}

sub num32vector-largest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_float_vector_largest_index($dst, $k, $v.vector);
  $dst.list
}
