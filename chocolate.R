FLAGS1 <- flags(
  flag_numeric("nodes1", 128),
  flag_numeric("batch_size", 100),
  flag_string("activation", "relu"),
  flag_numeric("learning_rate", 0.001),
  flag_numeric("epochs", 30),
  flag_numeric("nodes2", 250)
)


FLAGS2 <- flags(
  flag_numeric("nodes1", 64),
  flag_numeric("batch_size", 200),
  flag_string("activation", "sigmoid"),
  flag_numeric("learning_rate", 0.005),
  flag_numeric("epochs", 50),
  flag_numeric("nodes2", 200)
)

model =keras_model_sequential()

model %>%
  layer_dense(units = FLAGS1$nodes1, activation =
                FLAGS1$activation, input_shape = dim(chocolate_train_final)[2]) %>% layer_dropout(0.5) %>% 
  layer_dense(units = FLAGS2$nodes2, activation = FLAGS2$activation) %>% layer_dropout(0.5) %>%
  layer_dense(units = 1)

model %>% compile(
  optimizer = optimizer_adam(lr=FLAGS1$learning_rate),
  loss = 'mse')

model %>% fit(
  chocolate_train_final , chocolate_train_final_lables, epochs = FLAGS1$epochs
  , batch_size= FLAGS1$batch_size,
  validation_data=list(chocolate_val_final, chocolate_val_final_lables ))

