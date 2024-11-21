library(hexSticker)
library(magick)
library(sysfonts)
library(tidyverse) 

wnba_img<- image_read('wnba.png')

sticker(
  subplot = wnba_img,
  package = "wnbaherstory",
  s_width = 0.9,
  s_height = 0.9,
  s_x = 1,
  s_y = 0.75,
  p_size = 15,
  h_fill = '#fa4d00',
  h_color = '#fa4d00',
  h_size = 1.5,
  p_color = 'white'
) %>% print()