function getIcons() as object
    dest = "pkg:/images/FHD/"
    'todo: $$RES$$ authomatic choose res
    return {
        menuIcons: {
            SHOW_ALL_INACTIVE: dest + "show_all_inactive.png"
            SHOW_ALL_ACTIVE: dest + "show_all_active.png"
            SEARCH_INACTIVE: dest + "search_inactive.png"
            SEARCH_ACTIVE: dest + "search_active.png"
        }
        search:{
            ACCEPT_INACTIVE: dest + "accept_inactive.png"
            ACCEPT_ACTIVE: dest + "accept_active.png"
        }
        logos: {
            LOGO: dest + "logo.png"
        }
    }
end function
