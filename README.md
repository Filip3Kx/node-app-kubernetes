# CI/CD of a forked repository

Forked this repository to play around while learning kubernetes.

![image](https://github.com/Filip3Kx/node-app-kubernetes/assets/114138650/d874de5b-ffb4-4cf0-99de-c8a16fca166c)

- Jenkins job starts from the [Jenkinsfile](https://github.com/Filip3Kx/node-app-kubernetes/blob/main/Jenkinsfile)
- Using unit tests build into the docker compose
- Pushing images to [GCP Artifact Registry](https://cloud.google.com/artifact-registry)
- Deploying new app image to [GKE](https://cloud.google.com/kubernetes-engine)
- Storing logs in a [GCS](https://cloud.google.com/storage?utm_source=google&utm_medium=cpc&utm_campaign=emea-pl-all-en-dr-skws-all-all-trial-b-gcp-1011340&utm_content=text-ad-none-any-dev_c-cre_652004198065-adgp_Hybrid%20%7C%20SKWS%20-%20BRO%20%7C%20Txt%20~%20Storage%20~%20Cloud%20Storage%23v1-kwid_43700077695723194-kwd-10836346030-userloc_9067379&utm_term=kw_online%20cloud%20storage-net_g-plac_&&gad=1&gclid=CjwKCAjwyNSoBhA9EiwA5aYlb-WqlpNQc_2hBlMWnplIspAGgcOsyd1v6okRBDOxBqKBQop-9xFpPRoCw_IQAvD_BwE&gclsrc=aw.ds) bucket

![image](https://github.com/Filip3Kx/node-app-kubernetes/assets/114138650/2de0ceb8-b50e-4481-aca5-0f55f64c4381)

## Infrastracture

Everything considering the application can be created using the provided [terraform configuration](https://github.com/Filip3Kx/node-app-kubernetes/tree/main/terraform). It will spin up a separete network with a [GKE](https://cloud.google.com/kubernetes-engine) cluster.

After deploying the [app on Kubernetes](https://github.com/Filip3Kx/node-app-kubernetes/tree/main/kubernetes) for the first time the app image will get updated from the pipeline.
![image](https://github.com/Filip3Kx/node-app-kubernetes/assets/114138650/5736edcb-dc0f-422e-8f13-2ea48e9cb5d8)



