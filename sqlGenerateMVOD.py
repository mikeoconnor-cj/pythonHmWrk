measure_cds = [
    'total_pmpy_partb_quarter'
    , 'total_pmpy_hosp_ip_quarter'
    , 'total_avg_hcc_risk_quarter'
    , 'total_ra_pmpy_partbdme_quarter'
    , 'total_pmpy_op_quarter'
    , 'total_pmpy_hh_quarter'
    , 'total_ra_pmpy_snf_quarter'
    , 'total_pmpy_snf_quarter'
    , 'total_ra_pmpy_hospice_quarter'
    , 'total_ra_pmpy_hosp_ip_quarter'
    , 'total_pmpy_partbdme_quarter'
    , 'total_ra_pmpy_op_quarter'
    , 'total_member_years_quarter'
    , 'total_ra_pmpy_quarter'
    , 'total_pmpy_hospice_quarter'
    , 'total_pmpy_quarter'
    , 'tcm_compliant_discharges_quarter'
    , 'tcm_eligible_discharges_quarter'
]

sqlString = ''
indx = 1

for item in measure_cds:

    sqlString += """
        select
            org_id,
            org_level_category_cd,
            org_group_id,
            sum(case when period_id = 'q-2018-1' then measure_value_decimal else 0 end) as "q-2018-1",
            sum(case when period_id = 'q-2018-2' then measure_value_decimal else 0 end) as "q-2018-2",
            sum(case when period_id = 'q-2018-3' then measure_value_decimal else 0 end) as "q-2018-3",
            sum(case when period_id = 'q-2018-4' then measure_value_decimal else 0 end) as "q-2018-4",
            sum(case when period_id = 'q-2019-1' then measure_value_decimal else 0 end) as "q-2019-1",
            sum(case when period_id = 'q-2019-2' then measure_value_decimal else 0 end) as "q-2019-2",
            sum(case when period_id = 'q-2019-3' then measure_value_decimal else 0 end) as "q-2019-3",
            sum(case when period_id = 'q-2019-4' then measure_value_decimal else 0 end) as "q-2019-4",
            sum(case when period_id = 'q-2020-1' then measure_value_decimal else 0 end) as "q-2020-1",
            sum(case when period_id = 'q-2020-2' then measure_value_decimal else 0 end) as "q-2020-2",
            sum(case when period_id = 'q-2020-3' then measure_value_decimal else 0 end) as "q-2020-3"
        from DEV_A1052.INSIGHTS.metric_value_operational_dashboard
        where measure_cd = '{item}'
            and patient_medicare_group_cd = '#NA'
            and org_level_category_cd = 'aco'
            and attribution_type = 'as_was'
            and substr(period_id,1,1) = 'q'
            and period_id between 'q-2018-1' and 'q-2020-3'
        group by org_id,
            org_level_category_cd,
            org_group_id
        order by org_id,
            org_level_category_cd,
            org_group_id

    """.format(item=item)

    if indx < len(measure_cds):
        sqlString += """

            UNION 

        """

    indx += 1

print(sqlString)