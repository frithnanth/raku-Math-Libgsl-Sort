use v6.c;

unit class Math::Libgsl::Sort::Int16:ver<0.0.2>:auth<zef:FRITH>;

use Math::Libgsl::Raw::Sort::Int16 :ALL;
use Math::Libgsl::Vector;
use Math::Libgsl::Permutation;
use NativeCall;

# Sort::Int16ing vectors
sub int16sort(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[int16] $d .= new: @data».Num;
  gsl_sort_short($d, $stride, ($d.list.elems / $stride).ceiling);
  $d.list
}

sub int16sort2(:@data1, Int :$stride1? = 1, :@data2, Int :$stride2? = 1 --> List) is export {
  my CArray[int16] $d1 .= new: @data1».Num;
  my CArray[int16] $d2 .= new: @data2».Num;
  gsl_sort_short2($d1, $stride1, $d2, $stride2, ($d1.list.elems / $stride1).ceiling);
  out1 => $d1.list, out2 => $d2.list
}

sub int16sort-index(:@data, Int :$stride? = 1 --> List) is export {
  my CArray[int16] $d .= new: @data».Num;
  my size_t $n = ($d.list.elems / $stride).ceiling;
  my $p = CArray[size_t].allocate($n);
  gsl_sort_short_index($p, $d, $stride, $n);
  $p.list
}

sub int16sort-vector(Math::Libgsl::Vector $v) is export {
  gsl_sort_short_vector($v.vector)
}

sub int16sort2-vector(Math::Libgsl::Vector $v1, Math::Libgsl::Vector $v2) is export {
  gsl_sort_short_vector2($v1.vector, $v2.vector)
}

sub int16sort-vector-index(Math::Libgsl::Vector $v, Math::Libgsl::Permutation $p where $v.vector.size == *.p.size) is export {
  gsl_sort_short_vector_index($p.p, $v.vector)
}

# Selecting the k smallest or largest elements
sub int16smallest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[int16] $src .= new: @data».Num;
  my $dst = CArray[int16].allocate: $k;
  gsl_sort_short_smallest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub int16largest(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[int16] $src .= new: @data».Num;
  my $dst = CArray[int16].allocate: $k;
  gsl_sort_short_largest($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub int16smallest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[int16] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_short_smallest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub int16largest-index(:@data, Int :$stride? = 1, Int :$k? where * ≤ (@data.elems / $stride).ceiling = @data.elems --> List) is export {
  my CArray[int16] $src .= new: @data».Num;
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_short_largest_index($dst, $k, $src, $stride, ($src.list.elems / $stride).ceiling);
  $dst.list
}

sub int16vector-smallest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[int16].allocate: $k;
  gsl_sort_short_vector_smallest($dst, $k, $v.vector);
  $dst.list
}

sub int16vector-largest(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[int16].allocate: $k;
  gsl_sort_short_vector_largest($dst, $k, $v.vector);
  $dst.list
}

sub int16vector-smallest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_short_vector_smallest_index($dst, $k, $v.vector);
  $dst.list
}

sub int16vector-largest-index(Math::Libgsl::Vector $v, Int $k? where * < $v.vector.size = $v.vector.size --> List) is export {
  my $dst = CArray[size_t].allocate: $k;
  gsl_sort_short_vector_largest_index($dst, $k, $v.vector);
  $dst.list
}
