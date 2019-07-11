library(tidyverse)
library(readxl)

df <- read_excel("base-agregada.xlsx")

ggplot(df) +
  geom_point(aes(x = mass_co, y = mass_no, colour = dayofweek)) 
  
df2 <- df %>% select(mass_no, mass_co, time) %>% sample_n(15)

df %>% 
  gather(poluente, conc, mass_no, mass_co) %>% 
  ggplot() +
  geom_line(aes(x = time, y = conc)) +
  facet_wrap(~poluente, scales = "free_y")

p <- df %>% 
  gather(poluente, conc, mass_no, mass_co) %>% 
  group_by(poluente, hour) %>% 
  summarise(conc = mean(conc, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = hour, y = conc)) +
  facet_wrap(~poluente, scales = "free_y") +
  scale_x_continuous(breaks = seq(0, 24, 4))

plotly::ggplotly(p)  
