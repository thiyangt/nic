#' Nature Inspired Colour Palatte Package
#'
#'This is a collection of color palettes for R inspired by leaves. This work is inspired by the
#'pnwcolours package in R and codes are modifies using pnwcolours.
#' Create colour palettes
#' Names: applecroton, colleasa, colleasb
#' Type  \code{names(nic_palettes)} to view the names of colour palattes
#' @export
nic_palettes <- list(
  applecroton = rbind(c('#00441b', '#FFFF00'),c(1, 2)),
  colleasa = rbind(c('#78c679', '#67001f'),c(1, 2)),
  colleasb = rbind(c('#238b45', '#67001f', '#e7298a'),c(1, 2, 3))
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
#' nic_palette("applecroton",n=100,type="continuous")
#' nic_palette("colleasa",3)
#' nic_palette("colleasb",50)
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
