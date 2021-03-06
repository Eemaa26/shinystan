output$ui_trivariate_selectize <- renderUI({
  fluidRow(
    column(3, selectizeInput("trivariate_param_x", label = h5(style = "color: #428bca;", "x-axis"), choices = .make_param_list(object), selected = input$param, multiple = FALSE)),
    column(3, selectizeInput("trivariate_param_y", label = h5(style = "color: #428bca;", "y-axis"), choices = .make_param_list(object), selected = .make_param_list(object)[1], multiple = FALSE)),
    column(3, selectizeInput("trivariate_param_z", label = h5(style = "color: #428bca;", "z-axis"), choices = rev(.make_param_list(object)), multiple = FALSE))
  )
})

