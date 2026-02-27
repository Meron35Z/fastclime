# fastclime

Fork of fastclime to fix memory issues. 

## Memory Leak Fix

The fix addresses a memory leak in the `dantzig` solver function in `src/dantzig.c`.
`output_vec` was being allocated via `CALLOC` inside the lambda path iteration loop but was not being freed in previous versions, causing memory usage to grow with the number of lambda steps.
The fix involves explicitly freeing `output_vec` at the end of each iteration.
