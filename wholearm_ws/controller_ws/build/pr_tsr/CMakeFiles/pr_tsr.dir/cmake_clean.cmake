file(REMOVE_RECURSE
  "libpr_tsr.a"
  "libpr_tsr.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/pr_tsr.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
