
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nic

<!-- badges: start -->
<!-- badges: end -->

## Nature Inspired Colour Palette.

## Installation

You can install the released version of nic from
[Github](https://github.com/thiyangt/nic) with:

``` r
#devtools::install_github("thiyangt/nic")
library(nic)
```

## Example

This is a basic example which shows you how to solve a common problem:

![](https://github.com/thiyangt/nic/blob/main/data-raw/colleas1b.JPG)

``` r
library(nic)
## basic example code
library(palmerpenguins)
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
#> ✓ tibble  3.1.5     ✓ dplyr   1.0.7
#> ✓ tidyr   1.1.4     ✓ stringr 1.4.0
#> ✓ readr   1.4.0     ✓ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
ggplot(data = penguins, 
       aes(x = flipper_length_mm,
           y = body_mass_g)) +
  geom_point(aes(color = species, 
                 shape = species),
             size = 3) +
  scale_color_manual(values = nic_palette("colleasb",3)) +
  labs(title = "Penguin size, Palmer Station LTER",
       subtitle = "Flipper length and body mass for Adelie, Chinstrap and Gentoo Penguins",
       x = "Flipper length (mm)",
       y = "Body mass (g)",
       color = "Penguin species",
       shape = "Penguin species") 
#> Warning: Removed 2 rows containing missing values (geom_point).
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r
pal=nic_palette("colleasb",3)
ggplot(data.frame(x = rnorm(1e4), y = rnorm(1e4)), aes(x = x, y = y)) +
  geom_hex() +
  coord_fixed() +
  scale_fill_gradientn(colours = pal) + ggtitle("colleasb")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

![](https://github.com/thiyangt/nic/blob/main/data-raw/colleas1a.jpg)

``` r
pal <- nic_palette("colleasa",2)
penguins2 <- penguins %>% drop_na()
ggplot(data = penguins2, 
       aes(y = flipper_length_mm,
           x = sex,
           fill=sex)) +
  geom_boxplot() +
  scale_fill_manual(values = pal) + ggtitle("colleasa")
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

![](https://github.com/thiyangt/nic/blob/main/data-raw/wishbone.jpg)

``` r
library(purrr)
pal <- nic_palette("wishbone",3)
penguins %>% ggplot(aes(x=species, fill=island)) + geom_bar() +
  scale_fill_manual(values = pal) + ggtitle("wishbone")
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />
