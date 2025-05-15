import pandas as pd

data = pd.DataFrame("./waveform-inversion/sample_submission.csv")


data = data.head(210)

data.to_csv("resample_submission.csv")