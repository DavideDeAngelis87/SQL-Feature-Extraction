# Bank Customer Feature Engineering (SQL)

### Descrizione del Progetto

Sviluppo di una pipeline di Feature Engineering in SQL per la trasformazione di dati bancari relazionali e transazionali in una tabella denormalizzata (Feature Store) centrata sul singolo cliente (`id_cliente`). 
Il progetto sintetizza lo storico delle transazioni, la composizione del portafoglio prodotti e le caratteristiche demografiche per alimentare modelli di Machine Learning supervisionati (es. Churn Prediction, Credit Scoring, Next Best Action e Fraud Detection), eliminando la frammentazione dei dati operativi e migliorando la prontezza analitica dell'azienda.

### Workflow Tecnico e Metodologia

1. **Database Relational Inspection**: analisi del modello dati distribuito tra anagrafica clienti, conti posseduti, tipologie di conto, transazioni effettuate e tipologie di transazione.
2. **Modular Architecture via CTE**: strutturazione della query mediante Common Table Expressions (`WITH`) isolate per garantire manutenibilità, leggibilità e performance di esecuzione.
3. **Temporal & Demographic Calculation**: calcolo dinamico dell'età dei clienti a partire dalla data di nascita tramite funzioni temporali (`TIMESTAMPDIFF`).
4. **Conditional Aggregation & Feature Extraction**: estrazione di indicatori comportamentali specifici tramite l'uso combinato di funzioni aggregate e logica condizionale (`SUM(CASE WHEN...)`) per separare:
   * Flussi monetari in entrata/uscita e frequenza delle transazioni globali.
   * Distribuzione dei conti posseduti per singola tipologia.
   * Interazione incrociata tra tipologia di conto e direzione/volume della transazione.
5. **Final Table Assembly**: coordinamento dei `LEFT JOIN` sulla chiave primaria `id_cliente` per garantire l'integrità del dataset risultante senza perdita di record anagrafici.

### Tech Stack

* **Linguaggio**: SQL (MySQL)
* **Costrutti Avanzati**: Common Table Expressions (`WITH`), Aggregazioni condizionali (`SUM(CASE WHEN...)`), `LEFT JOIN` multipli, Funzioni temporali (`TIMESTAMPDIFF`, `CURRENT_DATE`).

### Valore Strategico

* **Predictive Analytics Readiness**: predisposizione immediata di oltre 25 feature comportamentali pronte per l'addestramento di modelli di Machine Learning supervisionato.
* **Risk & Churn Mitigation**: estrazione di indicatori di contrazione dell'operatività o variazione dei volumi utili a identificare precocemente clienti a rischio abbandono, insolvenza o frodi.
* **Customer Lifetime Value & Cross-Selling**: mappatura di dettaglio delle preferenze d'uso dei prodotti per la personalizzazione delle offerte commerciali.

### Struttura del Repository

* `Analisi_clienti_banca.sql`: script SQL contenente le CTE modulari per il calcolo e l'estrazione della tabella di feature denormalizzata.
