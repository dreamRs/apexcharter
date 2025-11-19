# Run Shiny input events examples

Run Shiny input events examples

## Usage

``` r
run_demo_input(example = c("click", "zoom", "selection"))
```

## Arguments

- example:

  Name of the example.

## Examples

``` r
if (interactive()) {

  run_demo_input("click")
  run_demo_input("zoom")
  run_demo_input("selection")

}
```
