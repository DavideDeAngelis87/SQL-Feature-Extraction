with 
-- Indicatori di Base (eta)
eta_cliente as
(select
id_cliente,
timestampdiff(year, data_nascita, current_date()) as eta
from banca.cliente),

-- Indicatori sulle transazioni
num_trans_cl as (select
cnt.id_cliente,
sum(case when tptr.segno = '+' then 1 else 0 end) as 'num_tr_+',
sum(case when tptr.segno = '-' then 1 else 0 end) as 'num_tr_-',
sum(case when tptr.segno = '+' then importo else 0 end) as 'sum_importo_+',
sum(case when tptr.segno = '-' then importo else 0 end) as 'sum_importo_-'
from banca.transazioni trans
left join banca.tipo_transazione tptr
on trans.id_tipo_trans = tptr.id_tipo_transazione
left join banca.conto cnt
on trans.id_conto = cnt.id_conto
group by cnt.id_cliente),

-- Indicatori sui conti
conti as (select
id_cliente,
count(id_conto) as 'numero_conti',
sum(case when id_tipo_conto = 0 then 1 else 0 end) as 'conto_0',
sum(case when id_tipo_conto = 1 then 1 else 0 end) as 'conto_1',
sum(case when id_tipo_conto = 2 then 1 else 0 end) as 'conto_2',
sum(case when id_tipo_conto = 3 then 1 else 0 end) as 'conto_3'
from banca.conto
group by id_cliente
),

-- Indicatori sulle transazioni per tipologia di conto
tipo_conti as (select
cnt.id_cliente,
sum(case when cnt.id_tipo_conto = 0 and tptr.segno = '+' then 1 else 0 end) as 'tr_cnt0_+',
sum(case when cnt.id_tipo_conto = 0 and tptr.segno = '-' then 1 else 0 end) as 'tr_cnt0_-',
sum(case when cnt.id_tipo_conto = 0 and tptr.segno = '+' then importo else 0 end) as 'importo_cnt0_+',
sum(case when cnt.id_tipo_conto = 0 and tptr.segno = '-' then importo else 0 end) as 'importo_cnt0_-',
sum(case when cnt.id_tipo_conto = 1 and tptr.segno = '+' then 1 else 0 end) as 'tr_cnt1_+',
sum(case when cnt.id_tipo_conto = 1 and tptr.segno = '-' then 1 else 0 end) as 'tr_cnt1_-',
sum(case when cnt.id_tipo_conto = 1 and tptr.segno = '+' then importo else 0 end) as 'importo_cnt1_+',
sum(case when cnt.id_tipo_conto = 1 and tptr.segno = '-' then importo else 0 end) as 'importo_cnt1_-',
sum(case when cnt.id_tipo_conto = 2 and tptr.segno = '+' then 1 else 0 end) as 'tr_cnt2_+',
sum(case when cnt.id_tipo_conto = 2 and tptr.segno = '-' then 1 else 0 end) as 'tr_cnt2_-',
sum(case when cnt.id_tipo_conto = 2 and tptr.segno = '+' then importo else 0 end) as 'importo_cnt2_+',
sum(case when cnt.id_tipo_conto = 2 and tptr.segno = '-' then importo else 0 end) as 'importo_cnt2_-',
sum(case when cnt.id_tipo_conto = 3 and tptr.segno = '+' then 1 else 0 end) as 'tr_cnt3_+',
sum(case when cnt.id_tipo_conto = 3 and tptr.segno = '-' then 1 else 0 end) as 'tr_cnt3_-',
sum(case when cnt.id_tipo_conto = 3 and tptr.segno = '+' then importo else 0 end) as 'importo_cnt3_+',
sum(case when cnt.id_tipo_conto = 3 and tptr.segno = '-' then importo else 0 end) as 'importo_cnt3_-'
from banca.transazioni trans
left join banca.conto cnt
on trans.id_conto = cnt.id_conto
left join banca.tipo_transazione tptr
on trans.id_tipo_trans = tptr.id_tipo_transazione
group by cnt.id_cliente)

select
eta.id_cliente,
eta.eta,
numtr.`num_tr_+`,
numtr.`num_tr_-`,
numtr.`sum_importo_+`,
numtr.`sum_importo_-`,
conti.numero_conti,
conti.conto_0,
conti.conto_1,
conti.conto_2,
conti.conto_3,
tpcnt.`tr_cnt0_+`,
tpcnt.`tr_cnt0_-`,
tpcnt.`importo_cnt0_+`,
tpcnt.`importo_cnt0_-`,
tpcnt.`tr_cnt1_+`,
tpcnt.`tr_cnt1_-`,
tpcnt.`importo_cnt1_+`,
tpcnt.`importo_cnt1_-`,
tpcnt.`tr_cnt2_+`,
tpcnt.`tr_cnt2_-`,
tpcnt.`importo_cnt2_+`,
tpcnt.`importo_cnt2_-`,
tpcnt.`tr_cnt3_+`,
tpcnt.`tr_cnt3_-`,
tpcnt.`importo_cnt3_+`,
tpcnt.`importo_cnt3_-`
from eta_cliente eta
left join num_trans_cl numtr
on eta.id_cliente = numtr.id_cliente
left join conti conti
on eta.id_cliente = conti.id_cliente
left join tipo_conti tpcnt
on eta.id_cliente = tpcnt.id_cliente
order by eta.id_cliente