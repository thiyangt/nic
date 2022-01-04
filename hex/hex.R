library(hexSticker)
library(showtext)
library(here)
font_add_google("Gochi Hand", "gochi")
## Automatically use showtext to render text for future devices
showtext_auto()
#imgurl <- system.file("figures/hex.jpg", package="hexSticker")
sticker(here("hex","Rplot.png"), package="nic",
        p_color="#99000d",
        p_size=15, s_x=1, s_y=.85, s_width=.43,
        h_fill = "#addd8e",
        filename=here("hex",  "hexsticker.png"),
        h_color="#238443",
        p_family = "gochi")
