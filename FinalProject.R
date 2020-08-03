
library(tidyverse)
library(ggplot2)
library(GGally)

cb_palette = c("#fab06e","#40a5ed","#1F77B4", "#FF7F0E", "#F0E442", "#0072B2", "#56B4E9", "#009E73", "#999999", "#E69F00",  
               "#D55E00", "#CC79A7")


#Data Source: https://www.kaggle.com/sulianova/cardiovascular-disease-dataset

## Data Reading and cleaning
Data_cat = read.csv("cardio_train.csv", header = TRUE, sep = ";")
Data_cat.copy = Data_cat
Data_cat = filter(Data_cat, ap_hi > 0 & ap_hi < 400, ap_lo > 0 & ap_lo < 400)
Data_cat$age = as.integer(Data_cat$age/365)

Data_cat$gender[Data_cat$gender==2] <- "Male"
Data_cat$gender[Data_cat$gender==1] <- "Female"
Data_cat$gender <- as.factor(Data_cat$gender)

Data_cat.pres = Data_cat[Data_cat$cardio == 1, ]
Data_cat.abs = Data_cat[Data_cat$cardio == 0, ]




ggplot(Data_cat, aes(x = height, fill= as.factor(cardio))) + 
  geom_density(position = "stack") +
  geom_vline(aes(xintercept=mean(height)), color="black", linetype="dashed", size=1) +
  xlab("Height(in cm) ") + ylab("Proportion") + 
  ggtitle(expression(atop("Height Distribution (stacked)", atop(italic("vertical line is mean height of overall population"), "")))) +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim(130, 207) + facet_wrap(~gender)+
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))






ggplot(Data_cat, aes(x = weight, fill= as.factor(cardio))) + 
  geom_density(position = "stack") +
  geom_vline(aes(xintercept=mean(weight)), color="black", linetype="dashed", size=1) +
  xlab("Weight(in kg)") + ylab("Proportion") + 
  ggtitle(expression(atop("Weight Distribution (stacked)", atop(italic("vertical line is mean weight of overall population"), "")))) +
  geom_vline(aes(xintercept=mean(height)), color="black", linetype="dashed", size=1) +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim(45,120) +facet_wrap(~gender)+
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))




ggplot(Data_cat, aes(x = ap_hi, fill= as.factor(cardio))) + 
  geom_density(position = "stack") +
  geom_vline(aes(xintercept=mean(ap_hi)), color="black", linetype="dashed", size=1) +
  xlab("Systolic blood pressure(mmHg)") + ylab("Proportion") + 
  ggtitle(expression(atop("Systolic blood pressure Distribution", atop(italic("vertical line is mean systolic blood pressure of overall population"), "")))) +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim (75, 200) +facet_wrap(~gender)+ 
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))





ggplot(Data_cat, aes(x = as.factor(cholesterol), fill= as.factor(cardio))) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), width = 0.5, position=position_dodge())+ 
  xlab("Cholesterol") + ylab("Overall Proportion") + 
  ggtitle("Cholesterol Distribution") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('normal','above \nnormal', 'well above \nnormal')) +
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))





ggplot(Data_cat, aes(x = as.factor(active), fill= as.factor(cardio))) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), width = 0.5, position=position_dodge())+ 
  xlab("Physically") + ylab("Overall Proportion") + 
  ggtitle("Physical Activity Distribution") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) +
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('Inactive','Active')) +
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))


## Modelling 

ggplot(Data_cat, aes(x = as.factor(active), fill= as.factor(cardio))) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), width = 0.5, position=position_dodge())+ 
  xlab("Physically") + ylab("Overall Proportion") + 
  ggtitle("Physical Activity Distribution") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) +
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('Inactive','Active')) +
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))



logit.df %>% group_by(gender) %>% summarise(mean(.fitted))


# # accuracy of the model
accuracy =  mean(logit.df$cardio == prediction ,na.rm= TRUE )
print("Accuracy")
accuracy*100


require(scales)

x = data.frame(pred = pred.value.prob, value = prediction, cardio = as.factor(logit.df$cardio))
ggplot(x, aes(x = pred, ..count.., fill = cardio)) +
  # geom_histogram() +
  geom_density(position = "stack") +
  labs(title = 'Distribution of fitted values') +
  xlab('Fitted Probability Values') +
  ylab('Count') +
  scale_y_continuous(labels = comma) +
  scale_fill_manual(values = cb_palette,
                    name="Cardiovascular \ndisease ",
                    labels=c("Absence", "Presence")) +
  scale_color_manual(values = cb_palette)+
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))


heart.data.male = Data_cat %>% filter(gender == "Male")
heart.data.male = heart.data.male %>%drop_na()

active_fix = 0
active.male = c(0,1)

cholesterol_fix = 2
cholesterol.male = c(1,2,3)

height.male = seq(65, 250, 1)
sim.dat_height.male = data.frame(height = height.male, 
                                 weight = median(heart.data.male$weight,na.rm=T),
                                 ap_hi = median(heart.data.male$ap_hi,na.rm=T),
                                 gender = "Male",
                                 cholesterol = cholesterol_fix,
                                 active = active_fix
)
sim.dat_height.male$Goal = predict(logit, newdata = sim.dat_height.male, type = "response")
sim.height.male.df = data.frame(Variable = rep(c("Height"),186),
                                Value = height.male,
                                heart_disease_prob = sim.dat_height.male$Goal,
                                gender = "Male")

weight.male = seq(10, 200, 1)
sim.dat_weight.male = data.frame(height = median(heart.data.male$height,na.rm=T), 
                                 weight = weight.male,
                                 ap_hi = median(heart.data.male$ap_hi,na.rm=T),
                                 gender = "Male",
                                 cholesterol = cholesterol_fix,
                                 active = active_fix)
# sim.dat_weight.male = sim.dat_weight.male %>%drop_na()
sim.dat_weight.male$Goal = predict(logit, newdata = sim.dat_weight.male, type = "response")
sim.weight.male.df = data.frame(Variable = rep(c("Weight"),191),
                                Value = weight.male,
                                heart_disease_prob = sim.dat_weight.male$Goal,
                                gender = "Male")

sys.male = seq(50, 250, 1)
sim.dat_sys.male = data.frame(height = median(heart.data.male$height,na.rm=T), 
                              weight = median(heart.data.male$weight,na.rm=T),
                              ap_hi = sys.male,
                              gender = "Male",
                              cholesterol = cholesterol_fix,
                              active = active_fix)
sim.dat_sys.male$Goal = predict(logit, newdata = sim.dat_sys.male, type = "response")
sim.ap_hi.male.df = data.frame(Variable = rep(c("Systolic Pressure"),201),
                               Value = sys.male,
                               heart_disease_prob = sim.dat_sys.male$Goal,
                               gender = "Male")


sim.dat_cholestero.male = data.frame(height = median(heart.data.male$height,na.rm=T), 
                                     weight = median(heart.data.male$weight,na.rm=T),
                                     ap_hi = median(heart.data.male$ap_hi,na.rm=T),
                                     gender = "Male",
                                     cholesterol = cholesterol.male,
                                     active = active_fix
)
sim.dat_cholestero.male$Goal = predict(logit, newdata = sim.dat_cholestero.male, type = "response")
sim.cholesterol.male.df = data.frame(Variable = rep(c("Cholesterol"),3),
                                     Value = cholesterol.male,
                                     heart_disease_prob = sim.dat_cholestero.male$Goal,
                                     gender = "Male")


sim.dat_active.male = data.frame(height = median(heart.data.male$height,na.rm=T), 
                                 weight = median(heart.data.male$weight,na.rm=T),
                                 ap_hi = median(heart.data.male$ap_hi,na.rm=T),
                                 gender = "Male",
                                 cholesterol = cholesterol_fix,
                                 active = active.male
)
sim.dat_active.male$Goal = predict(logit, newdata = sim.dat_active.male, type = "response")
sim.active.male.df = data.frame(Variable = rep(c("Active"),2),
                                Value = active.male,
                                heart_disease_prob = sim.dat_active.male$Goal,
                                gender = "Male")

grid.male.df <- rbind(sim.ap_hi.male.df, sim.height.male.df, sim.weight.male.df)


heart.data.female = Data_cat %>% filter(gender == "Female")
heart.data.female = heart.data.female %>%drop_na()

height.female = seq(65, 250, 1)
sim.dat_height.female = data.frame(height = height.female, 
                                   weight = median(heart.data.female$weight,na.rm=T),
                                   ap_hi = median(heart.data.female$ap_hi,na.rm=T),
                                   gender = "Female",
                                   cholesterol = cholesterol_fix,
                                   active = active_fix
)
sim.dat_height.female$Goal = predict(logit, newdata = sim.dat_height.female, type = "response")
sim.height.female.df = data.frame(Variable = rep(c("Height"),186),
                                  Value = height.female,
                                  heart_disease_prob = sim.dat_height.female$Goal,
                                  gender = "Female")

weight.female = seq(10, 200, 1)
sim.dat_weight.female = data.frame(height = median(heart.data.female$height,na.rm=T), 
                                   weight = weight.female,
                                   ap_hi = median(heart.data.female$ap_hi,na.rm=T),
                                   gender = "Female",
                                   cholesterol = cholesterol_fix,
                                   active = active_fix)
# sim.dat_weight.female = sim.dat_weight.female %>%drop_na()
sim.dat_weight.female$Goal = predict(logit, newdata = sim.dat_weight.female, type = "response")
sim.weight.female.df = data.frame(Variable = rep(c("Weight"),191),
                                  Value = weight.female,
                                  heart_disease_prob = sim.dat_weight.female$Goal,
                                  gender = "Female")

sys.female = seq(50, 250, 1)
sim.dat_sys.female = data.frame(height = median(heart.data.female$height,na.rm=T), 
                                weight = median(heart.data.female$weight,na.rm=T),
                                ap_hi = sys.female,
                                gender = "Female",
                                cholesterol = cholesterol_fix,
                                active = active_fix)
sim.dat_sys.female$Goal = predict(logit, newdata = sim.dat_sys.female, type = "response")
sim.ap_hi.female.df = data.frame(Variable = rep(c("Systolic Pressure"),201),
                                 Value = sys.female,
                                 heart_disease_prob = sim.dat_sys.female$Goal,
                                 gender = "Female")

cholesterol.female = c(1,2,3)
sim.dat_cholestero.female = data.frame(height = median(heart.data.female$height,na.rm=T), 
                                       weight = median(heart.data.female$weight,na.rm=T),
                                       ap_hi = median(heart.data.female$ap_hi,na.rm=T),
                                       gender = "Female",
                                       cholesterol = cholesterol.male,
                                       active = active_fix
)
sim.dat_cholestero.female$Goal = predict(logit, newdata = sim.dat_cholestero.female, type = "response")
sim.cholesterol.female.df = data.frame(Variable = rep(c("Cholesterol"),3),
                                       Value = cholesterol.female,
                                       heart_disease_prob = sim.dat_cholestero.female$Goal,
                                       gender = "Female")

active.female = c(0,1)
sim.dat_active.female = data.frame(height = median(heart.data.female$height,na.rm=T), 
                                   weight = median(heart.data.female$weight,na.rm=T),
                                   ap_hi = median(heart.data.female$ap_hi,na.rm=T),
                                   gender = "Female",
                                   cholesterol = cholesterol_fix,
                                   active = active.male
)
sim.dat_active.female$Goal = predict(logit, newdata = sim.dat_active.female, type = "response")
sim.active.female.df = data.frame(Variable = rep(c("Active"),2),
                                  Value = active.female,
                                  heart_disease_prob = sim.dat_active.female$Goal,
                                  gender = "Female")

grid.female.df <- rbind(sim.ap_hi.female.df, sim.height.female.df, sim.weight.female.df)


grid.df = rbind(grid.female.df, grid.male.df)
ggplot(grid.df,aes(x = Value, y = heart_disease_prob, color = gender)) + geom_line() + 
  facet_wrap(~Variable, scales = "free_x", ncol = 2)  + 
  scale_color_manual(values= cb_palette) +
  coord_cartesian(ylim = c(0, 1)) + 
  labs(title = "Fitted values of having heart disease for both the gender on quantitative variables", color='Gender') +      
  ylab("Probability of having heart disease") + xlab("Value") +
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))



sim.cholesterol.male.df$Value = as.factor(sim.cholesterol.male.df$Value)
sim.cholesterol.male.df$Value = recode_factor(sim.cholesterol.male.df$Value, `1` = "Normal", `2` = "Above Normal", `3` = "Well above Normal")

sim.cholesterol.female.df$Value = as.factor(sim.cholesterol.female.df$Value)
sim.cholesterol.female.df$Value = recode_factor(sim.cholesterol.female.df$Value, `1` = "Normal", `2` = "Above Normal", `3` = "Well above Normal")

sim.active.male.df$Value = as.factor(sim.active.male.df$Value)
sim.active.male.df$Value = recode_factor(sim.active.male.df$Value, `0` = "Inactive", `1` = "Active")

sim.active.female.df$Value = as.factor(sim.active.female.df$Value)
sim.active.female.df$Value = recode_factor(sim.active.female.df$Value, `0` = "Inactive", `1` = "Active")


grid.df = rbind(sim.cholesterol.male.df, sim.active.male.df, sim.cholesterol.female.df, sim.active.female.df)
ggplot(grid.df,aes(x = Value, y = heart_disease_prob, color = gender)) + geom_point() + 
  facet_wrap(~Variable, scales = "free_x", ncol = 2)  + 
  scale_color_manual(values= cb_palette) +
  coord_cartesian(ylim = c(0, 1)) + 
  labs(title = "Fitted values of having heart disease for both the gender on categorical variables", color='Gender') +      
  ylab("Probability of having heart disease") + xlab("Value") +
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))



## Appendix

gg = ggplot(Data_cat, aes(x = as.factor(cardio))) + 
  geom_bar(width = 0.25, fill="steelblue") + 
  ggtitle("Cardiovascular Disease") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(NULL) + ylab("Count") +
  scale_x_discrete(labels = c('Absence','Presence'))

gg + theme(
  plot.title = element_text(size = 11, face = "bold"),
  plot.subtitle = element_text(size = 8),
  axis.title.x = element_text(size = 9),
  axis.title.y = element_text(size = 9),
  legend.title=element_text(size=9), 
  legend.text=element_text(size=8))


#People with and without cardiovascular disease in the given dataset are almost equal

ggplot(Data_cat, aes(x = gender, fill= as.factor(cardio))) + 
  geom_bar(width = 0.5, position=position_dodge())+ 
  xlab(" ") + ylab("Count") + 
  ggtitle("Distribution of overall data according to gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  theme(
    plot.title = element_text(size = 11, face = "bold"),
    plot.subtitle = element_text(size = 8),
    axis.title.x = element_text(size = 9),
    axis.title.y = element_text(size = 9),
    legend.title=element_text(size=9), 
    legend.text=element_text(size=8))




# par(mfrow=c(1,2))

ggplot(Data_cat, aes(x = height, fill= as.factor(cardio))) + 
  geom_bar(binwidth = 2, position=position_dodge())+ 
  xlab("Height(in cm) ") + ylab("Count") + 
  ggtitle("Height conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim(130, 180) + facet_wrap(~gender)+
  theme(
    plot.title = element_text(size = 11, face = "bold"),
    plot.subtitle = element_text(size = 8),
    axis.title.x = element_text(size = 9),
    axis.title.y = element_text(size = 9),
    legend.title=element_text(size=9), 
    legend.text=element_text(size=8))



ggplot(Data_cat, aes(x = age, fill= as.factor(cardio))) + 
  geom_bar(binwidth = 2, position=position_dodge())+ xlab("Age (in yrs)") + ylab("Count") + 
  ggtitle("Age conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  facet_wrap(~gender)+
  theme(
    plot.title = element_text(size = 11, face = "bold"),
    plot.subtitle = element_text(size = 8),
    axis.title.x = element_text(size = 9),
    axis.title.y = element_text(size = 9),
    legend.title=element_text(size=9), 
    legend.text=element_text(size=8))



ggplot(Data_cat, aes(x = weight, fill= as.factor(cardio))) + 
  geom_bar(binwidth = 5, position=position_dodge())+ 
  xlab("Weight(in kg)") + ylab("Count") + 
  ggtitle("Weight conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim(45,120) +facet_wrap(~gender)+
  theme(
    plot.title = element_text(size = 11, face = "bold"),
    plot.subtitle = element_text(size = 8),
    axis.title.x = element_text(size = 9),
    axis.title.y = element_text(size = 9),
    legend.title=element_text(size=9), 
    legend.text=element_text(size=8))



ggplot(Data_cat, aes(x = ap_hi, fill= as.factor(cardio))) + 
  geom_bar(width = 10, position=position_dodge())+ 
  xlab("Systolic blood pressure(mmHg)") + ylab("Count") + 
  ggtitle("Systolic Blood Pressure conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim (50, 250) +facet_wrap(~gender)+ 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 12000)) +
  theme(
    plot.title = element_text(size = 11, face = "bold"),
    plot.subtitle = element_text(size = 8),
    axis.title.x = element_text(size = 9),
    axis.title.y = element_text(size = 9),
    legend.title=element_text(size=9), 
    legend.text=element_text(size=8))




ggplot(Data_cat, aes(x = ap_lo, fill= as.factor(cardio))) + 
  geom_bar(width = 5, position=position_dodge())+ 
  xlab("Diastolic blood pressure(mmHg)") + ylab("Count") + 
  ggtitle("Diastolic Blood Pressure conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim(50, 100) + facet_wrap(~gender) +
  theme(
    plot.title = element_text(size = 11, face = "bold"),
    plot.subtitle = element_text(size = 8),
    axis.title.x = element_text(size = 9),
    axis.title.y = element_text(size = 9),
    legend.title=element_text(size=9), 
    legend.text=element_text(size=8))




ggplot(Data_cat, aes(x = as.factor(cholesterol), fill= as.factor(cardio))) + 
  geom_bar(width = 0.5, position=position_dodge())+ 
  xlab("Cholesterol") + ylab("Count") + 
  ggtitle("Distribution of Cholesterol conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('normal','above \nnormal', 'well above \nnormal')) +
  theme(
  plot.title = element_text(size = 11, face = "bold"),
  plot.subtitle = element_text(size = 8),
  axis.title.x = element_text(size = 9),
  axis.title.y = element_text(size = 9),
  legend.title=element_text(size=9), 
  legend.text=element_text(size=8))



ggplot(Data_cat, aes(x = as.factor(gluc), fill= as.factor(cardio))) + 
  geom_bar(width = 0.5, position=position_dodge())+ 
  xlab("Glucose") + ylab("Count") + 
  ggtitle("Distribution of Glucose conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) +
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('normal','above \nnormal', 'well above \nnormal')) +
  theme(
  plot.title = element_text(size = 11, face = "bold"),
  plot.subtitle = element_text(size = 8),
  axis.title.x = element_text(size = 9),
  axis.title.y = element_text(size = 9),
  legend.title=element_text(size=9), 
  legend.text=element_text(size=8))




ggplot(Data_cat, aes(x = as.factor(smoke), fill= as.factor(cardio))) + 
  geom_bar(width = 0.5, position=position_dodge())+ 
  xlab(" ") + ylab("Count") + 
  ggtitle("Distribution of Smokers conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) +
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('Non-Smoker', 'Smoker')) +
  theme(
  plot.title = element_text(size = 11, face = "bold"),
  plot.subtitle = element_text(size = 8),
  axis.title.x = element_text(size = 9),
  axis.title.y = element_text(size = 9),
  legend.title=element_text(size=9), 
  legend.text=element_text(size=8))




ggplot(Data_cat, aes(x = as.factor(alco), fill= as.factor(cardio))) + 
  geom_bar(width = 0.5, position=position_dodge())+ 
  xlab(" ") + ylab("Count") + 
  ggtitle("Distribution of Alcohol Intake conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) +
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('Non-Alcoholic', 'Alcoholic')) +
  theme(
  plot.title = element_text(size = 11, face = "bold"),
  plot.subtitle = element_text(size = 8),
  axis.title.x = element_text(size = 9),
  axis.title.y = element_text(size = 9),
  legend.title=element_text(size=9), 
  legend.text=element_text(size=8))
  
  
  
ggplot(Data_cat, aes(x = as.factor(active), fill= as.factor(cardio))) + 
  geom_bar(width = 0.5, position=position_dodge())+ 
  xlab("Physical Activity") + ylab("Count") + 
  ggtitle("Distribution of Physical activity conditioned on gender") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) +
  facet_wrap(~gender) +
  scale_x_discrete(labels = c('Inactive','Active')) +
  theme(
  plot.title = element_text(size = 11, face = "bold"),
  plot.subtitle = element_text(size = 8),
  axis.title.x = element_text(size = 9),
  axis.title.y = element_text(size = 9),
  legend.title=element_text(size=9), 
  legend.text=element_text(size=8))



ggplot(Data_cat, aes(x = ap_hi, fill= as.factor(cardio))) + 
  geom_density(position = "fill") +
  geom_vline(aes(xintercept=mean(ap_hi)), color="black", linetype="dashed", size=1) +
  xlab("Systolic blood pressure(mmHg)") + ylab("Proportion") + 
  ggtitle(expression(atop("Systolic blood pressure Distribution", atop(italic("vertical line is mean systolic blood pressure of overall population"), "")))) +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(name = "Cardiovascular \nDisease", values = cb_palette, labels=c("Absent", "Present")) + 
  xlim (75, 200) +facet_wrap(~gender)+ 
  theme(
    plot.title = element_text(size = 11, face = "bold",color="navyblue"),
    plot.subtitle = element_text(size = 8, color="slateblue4", face = "bold.italic"),
    axis.title.x = element_text(size = 9,color="royalblue3",face="bold"),
    axis.title.y = element_text(size = 9,color="royalblue3",face="bold"),
    legend.title=element_text(size=9),
    legend.text=element_text(size=8))

