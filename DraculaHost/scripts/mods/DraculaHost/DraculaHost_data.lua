return {
    name = "Dracula Host",
    description = "Controls how loud Dracula is",
    is_togglable = true,
    options = {
        widgets = {
            {
                setting_id    = "dracula_volume",
                type          = "numeric",
                default_value = 100,
                range         = {0, 200},
                decimals_number = 0,
            },
        },
    },
}