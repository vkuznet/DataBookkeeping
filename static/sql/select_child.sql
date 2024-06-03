SELECT
    D.did CHILD_DID,
    PDS.did,
    D.create_at,
    D.create_by,
    D.modify_at,
    D.modify_by
FROM DATASETS D
LEFT OUTER JOIN PARENTS DSP ON DSP.DATASET_ID = D.DATASET_ID
LEFT OUTER JOIN DATASETS PDS ON PDS.DATASET_ID = DSP.PARENT_ID