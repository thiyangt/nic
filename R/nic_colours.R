#' Nature Inspired Colour Palatte Package
#'
#'This is a collection of color palettes for R inspired by leaves. This work is inspired by the
#'pnwcolours package in R and codes are modifies using pnwcolours.
#' Create colour palettes
#' Names: applecroton, colleasa, colleasb
#' Type  \code{names(nic_palettes)} to view the names of colour palattes
#' @export
nic_palettes <- list(
  applecroton_2 = rbind(c('#00441b', '#FFFF00'),c(1, 2)),
  coleusa_2 = rbind(c('#78c679', '#67001f'),c(1, 2)),
  coleusb_3 = rbind(c('#238b45', '#67001f', '#e7298a'),c(1, 2, 3)),
  coleus_density_7 = rbind(c('#ffff99', '#d9ef8b', '#a6d96a', '#66bd63', '#1a9850', '#e7298a', '#980043'),c(1, 2, 3, 4, 5, 6, 7)),
  wishbone_3 = rbind(c('#2d004b', '#8073ac', '#fff200'), c(1, 2, 3)),
  buttercup_12 = rbind(c('#e0e9dc', '#cbd7c4', '#b7c5ac', '#a3b396', '#90a181', '#7d906d', '#6c7e5a', '#5b6d49', '#4b5d39', '#3c4c2b', '#2d3c1d', '#202d11'),seq(12)),
  buttercup_8 = rbind(c('#e0e9dc', '#bfccb6', '#a0b093', '#829572', '#677955', '#4d5f3b', '#364525', '#202d11'),seq(8)),
  ixora_12 = rbind(c('#ed8870', '#ed7c64', '#ec7159', '#e9654d', '#e65a42', '#e15036', '#da472f', '#d1402a', '#c83925', '#bf3321', '#b42e1d', '#aa2a19'),seq(12)),
  ixora_8 = rbind(c('#ed8870', '#ec765e', '#e9644c', '#e35339', '#d8452e', '#ca3a26', '#ba311f', '#aa2a19'),seq(8)),
  moss_rose_5 = rbind(c('#f4a8d0','#ed6027','#d9986a','#cf3659','#e44294'),seq(5)),
  orchid_12 = rbind(c('#c295ba', '#ba8cb3', '#b282ac', '#ab79a5', '#a46f9e', '#9d6597', '#975b90', '#91518a', '#8b4880', '#853e77', '#80326e', '#811d68'),seq(12)),
  orchid_8 = rbind(c('#c295ba', '#b686af', '#aa77a4', '#9f6899', '#95588e', '#8c4982', '#833973', '#811d68'),seq(8)),
  squarestem_5 = rbind(c('#e89f4c', '#d95827', '#abc762', '#748b5c', '#947362'),seq(5)),
  papaya_11 = rbind(c('#a17f27', '#b18f2e', '#c19f3a', '#cfb04d', '#dbc268', '#e0d591', '#c8c677', '#b3b667', '#a0a65c', '#8d9553', '#7c854d'),seq(11)),
  kandyan_dancer_6 = rbind(c("#780e02", "#c94406","#c04e0f","#f3f30c", "#8fc912", "#3a9c02" ,"#034704"), seq(7))
)


# 2. Palette builder function
#::::::::::::::::::::::::::::::::::::::::::::::

#' NIC Palette Generator.
#'
#' This function builds palettes based on natural scenes in the Pacific Northwest. Each palette is inspired by the author's nature photography
#' of the region, and checked for color blind safety using \href{https://gka.github.io/palettes/#/9|s|00429d,96ffea,ffffe0|ffffe0,ff005e,93003a|1|1}{Chroma.js Color Palette Helper}.
#' View photos for each palette \href{https://github.com/thiyangt/nic}{On Github}.
#'
#' @param name Name of the color palette. Options are \code{applecroton}, \code{colleasa}, \code{colleasb}
#' @param n Number of colors in the palette. Palletes include 5-8 colors, which can be used discretely,
#' or if more are desired, used as a gradient. If omitted, n = length of palette.
#' @param type Usage of palette as "continuous" or "discrete". Continuous usage interpolates between colors to create
#' a scale of values. If omitted, function assumes continuous if n > length of palette, and discrete if n < length of palette.
#'
#' @return A vector of colors.
#'
#' @examples
#' nic_palette("applecroton_2",n=100,type="continuous")
#' nic_palette("coleusa_2",2)
#' nic_palette("coleusb_3",50)
#'
#' @export

nic_palette <- function(name, n, type = c("discrete", "continuous")) {

  pal <- nic_palettes[[name]]


  if (is.null(pal)){
    stop("Palette not found.")
  }

  if (missing(n)) {
    n <- length(pal[1,])
  }

  if (missing(type)) {
    if(n > length(pal[1,])){type <- "continuous"}
    else{ type <- "discrete"}
  }
  type <- match.arg(type)


  if (type == "discrete" && n > length(pal[1,])) {
    stop("Number of requested colors greater than what discrete palette can offer, \n  use as continuous instead.")
  }


  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal[1,])(n),
                discrete = pal[1,][pal[2,] %in% c(1:n)],
  )
  structure(out, class = "NICpalette", name = name)

}

#' @export



# 3. Palette Print Function
#::::::::::::::::::::::::::::::::::::::::
#' @importFrom graphics rect par image text
#' @importFrom stats median
print.NICpalette <- function(x, ...) {
  pallength <- length(x)
  NICpar <- par(mar=c(0.25,0.25,0.25,0.25))
  on.exit(par(NICpar))

  image(1:pallength, 1,
        as.matrix(1:pallength),
        col = x,
        axes=FALSE)

  text(median(1:pallength), 1,
       labels = paste0(attr(x,"name"),", n=",pallength),
       cex = 3, family = "sans")
}
