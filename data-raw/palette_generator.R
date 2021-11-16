library(magick)
library(tidyverse)
library(imager)
library(scales)
library(here)

get_color_palette <- function(file_name){
  new_image <- image_read(here("data-raw",file_name))
  n_colors <- 32
  colorspace <- "sRGB"
  resize_size <- "1000"

  quant_image <- new_image %>% image_resize(resize_size) %>%
    image_quantize(max=n_colors, colorspace=colorspace) %>%
    magick2cimg()

  rgb_qimage <- quant_image %>%
    as.data.frame(wide="c") %>%
    mutate(hex = rgb(c.1,c.2,c.3)) %>%
    rename(c("R" = "c.1","G" = "c.2","B" = "c.3"))

  hsv_qimage <- quant_image %>%
    RGBtoHSL() %>%
    as.data.frame(wide = "c") %>%
    mutate(hex = hsv(rescale(c.1, from=c(0,360)),c.2,c.3)) %>%
    rename(c("H" = "c.1","S" = "c.2","L" = "c.3"))

  qimage <- rgb_qimage %>%
    left_join(hsv_qimage %>% select(H,S,L,x,y),by = c("x","y")) %>%
    count(hex,R,G,B,H,S,L,sort=T,name = "count") %>%
    tibble() %>%
    mutate(hex = fct_reorder(factor(hex),L))

  qimage %>%
    ggplot(aes(y = count,x = hex,fill = hex)) +
    geom_bar(stat="identity") +
    scale_fill_identity() +
    theme_minimal() +
    coord_flip()
}

get_color_palette("buttercup.jpeg")
# Sequential :- #E0E9DC,#B9C5B2,#6D8658, #4C6636, #465834, #304917, #202D11
# n = 12 :- '#e0e9dc', '#cbd7c4', '#b7c5ac', '#a3b396', '#90a181', '#7d906d', '#6c7e5a', '#5b6d49', '#4b5d39', '#3c4c2b', '#2d3c1d', '#202d11'
# n = 8 :- '#e0e9dc', '#bfccb6', '#a0b093', '#829572', '#677955', '#4d5f3b', '#364525', '#202d11'

get_color_palette("ixora.jpeg")
# Sequential :- #ED8870,#E04D33,#ED6550,#AA2A19,#CC3725
# n = 8 :- '#ed8870', '#ec765e', '#e9644c', '#e35339', '#d8452e', '#ca3a26', '#ba311f', '#aa2a19'
# n = 12 :- '#ed8870', '#ed7c64', '#ec7159', '#e9654d', '#e65a42', '#e15036', '#da472f', '#d1402a', '#c83925', '#bf3321', '#b42e1d', '#aa2a19'

get_color_palette("moss_rose_1.jpeg")
get_color_palette("moss_rose_2.jpeg")
get_color_palette("moss_rose_3.jpeg")
# Qualitiative :
# n = 5 :- '#f4a8d0','#ed6027','#d9986a','#cf3659','#e44294'

get_color_palette("orchid.jpeg")
# Sequential :- #c295ba, #ae93a8, #9e6b9a, #915089, #8e3e85, #843874,  #782f67, #811d68
# n = 12 :- '#c295ba', '#ba8cb3', '#b282ac', '#ab79a5', '#a46f9e', '#9d6597', '#975b90', '#91518a', '#8b4880', '#853e77', '#80326e', '#811d68'
# n = 8 :- '#c295ba', '#b686af', '#aa77a4', '#9f6899', '#95588e', '#8c4982', '#833973', '#811d68'

get_color_palette("squarestem.jpeg")
# Qualitiative :
# n= 5 :- '#e89f4c', '#d95827', '#abc762', '#748b5c', '#947362'

get_color_palette("papaya.jpeg")
# Diverging
# n = 11 :- '#a17f27', '#b18f2e', '#c19f3a', '#cfb04d', '#dbc268', '#e0d591', '#c8c677', '#b3b667', '#a0a65c', '#8d9553', '#7c854d'
