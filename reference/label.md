# Label for annotations

Label for annotations

## Usage

``` r
label(
  text = NULL,
  borderColor = NULL,
  borderWidth = NULL,
  textAnchor = NULL,
  position = NULL,
  offsetX = NULL,
  offsetY = NULL,
  background = NULL,
  color = NULL,
  fontSize = NULL,
  fontWeight = NULL,
  fontFamily = NULL,
  cssClass = NULL,
  padding = c(2, 5, 2, 5)
)
```

## Arguments

- text:

  Text for the annotation label.

- borderColor:

  Border color for the label.

- borderWidth:

  Border width for the label.

- textAnchor:

  The alignment of text relative to label's drawing position.

- position:

  Available options: left or right.

- offsetX:

  Sets the left offset for annotation label.

- offsetY:

  Sets the top offset for annotation label.

- background:

  Background Color for the annotation label.

- color:

  ForeColor for the annotation label.

- fontSize:

  FontSize for the annotation label.

- fontWeight:

  Font-weight for the annotation label.

- fontFamily:

  Font-family for the annotation label.

- cssClass:

  A custom Css Class to give to the annotation label elements.

- padding:

  Padding for the label: top, right, bottom, left.

## Value

A `list` that can be used in
[`add_shade`](https://dreamrs.github.io/apexcharter/reference/add-shade.md),
[`add_point`](https://dreamrs.github.io/apexcharter/reference/add_point.md),
[`add_event`](https://dreamrs.github.io/apexcharter/reference/add_event.md),
[`add_event_marker`](https://dreamrs.github.io/apexcharter/reference/add_event_marker.md).
