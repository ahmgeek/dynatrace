# dynatrace
- [x] Get a Dynatrace Trial License and instrument a K8s cluster and instrument a sample application

- [ ] Create a presentation, that shows what Dynatrace provides for k8s and also what can be improved / what you would expect on top
- [x] Install Prometheus via Prometheus Operator
- [x] Install Keptn (keptn.sh) on the K8s cluster and deploy its sample app: carts
- [ ] Create a presentation that covers what keptn provides and - if so - what can be improved
- [x] Manually add a Scrape Job to Prometheus for the carts service (← sample app) to get monitoring data
- [x] Manually set an Alert Rule for Prometheus to get alerts in case of a problem, e.g., response time degradation
- [x] Extend the sample app to simulate a response time degradation To raise a problem - a response time degradation - for the sample app, execute the load test as shown
[here: ](https://tutorials.keptn.sh/tutorials/keptn-full-tour-prometheus-07/index.html#21) - `kubectl apply -f cartsloadgen-faulty.yaml` . When the load test is running, verify the response time degradation in Prometheus.
- [ ] How can the manual steps (step 4 and 5) be automated in the code of the Keptn service: prometheus-service? In other words, what has the prometheus-service to do when executing the command keptn configure monitoring prometheus —project=xyz?
(Reference to the [Keptn/Prometheus tutorial:](https://tutorials.keptn.sh/tutorials/keptn-full-tour-prometheus-07/index.html)
