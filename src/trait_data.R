library(traits)
options(betydb_key = readLines('key.txt', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

canopy_cover <- betydb_query(table = 'search',
                             trait = "canopy_cover",
                             site  = "~Season 6",
                             limit = '100')

write.csv(canopy_cover, file = "data/canopy_cover.csv")