# Highest Energy Consumption
# C. Ndege
# 1/30/2022

# Import your libraries
import pandas as pd

# union dataframes
fb_total_energy = pd.concat([fb_eu_energy, fb_asia_energy, fb_na_energy])

fb_energy_by_date = fb_total_energy.groupby('date')

fb_sum_energy_by_date = fb_energy_by_date['consumption'].sum()

fb_sum_energy_by_date = pd.DataFrame(fb_sum_energy_by_date).reset_index()

fb_sum_energy_by_date['energy_rank'] = fb_sum_energy_by_date['consumption'].rank(method='min', ascending=False)

fb_top_consumption = fb_sum_energy_by_date[fb_sum_energy_by_date['energy_rank'] == 1]

fb_top_consumption