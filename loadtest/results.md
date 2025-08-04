
         /\      Grafana   /‾‾/
    /\  /  \     |\  __   /  /
   /  \/    \    | |/ /  /   ‾‾\
  /          \   |   (  |  (‾)  |
 / __________ \  |_|\_\  \_____/

     execution: local
        script: loadtest/api_load.js
        output: -

     scenarios: (100.00%) 1 scenario, 50 max VUs, 1m30s max duration (incl. graceful stop):
              * default: 50 looping VUs for 1m0s (gracefulStop: 30s)



  █ THRESHOLDS

    http_req_duration
    ✗ 'p(95)<500' p(95)=606.13ms

    http_req_failed
    ✓ 'rate<0.01' rate=0.00%


  █ TOTAL RESULTS

    checks_total.......................: 2461    41.299717/s
    checks_succeeded...................: 100.00% 2461 out of 2461
    checks_failed......................: 0.00%   0 out of 2461

    ✓ status is 200

    HTTP
    http_req_duration.......................................................: avg=228.43ms min=64.9µs med=170.96ms max=2.55s p(90)=202.24ms p(95)=606.13ms
      { expected_response:true }............................................: avg=228.43ms min=64.9µs med=170.96ms max=2.55s p(90)=202.24ms p(95)=606.13ms
    http_req_failed.........................................................: 0.00%  0 out of 2461
    http_reqs...............................................................: 2461   41.299717/s

    EXECUTION
    iteration_duration......................................................: avg=1.23s    min=1.16s  med=1.17s    max=3.55s p(90)=1.2s     p(95)=1.68s
    iterations..............................................................: 2461   41.299717/s
    vus.....................................................................: 26     min=26        max=50       
    vus_max.................................................................: 50     min=50        max=50       

    NETWORK
    data_received...........................................................: 18 MB  309 kB/s
    data_sent...............................................................: 301 kB 5.0 kB/s



                                                                                                                
running (0m59.6s), 00/50 VUs, 2461 complete and 0 interrupted iterations                                        
default ✓ [======================================] 50 VUs  1m0s                                                 
ERRO[0061] thresholds on metrics 'http_req_duration' have been crossed



# Load Test: /api/books

## Config
- Virtual Users: 50
- Duration: 60 seconds
- Sleep between requests: 1s

## Results
- Total Requests: 2461
- Errors: 0.00%
- Avg Latency: 228ms
- 95th Percentile: 606ms ❌ (SLO breach)
- Max Latency: 2.55s
- Data Sent: 301 KB
- Data Received: 18 MB

## Observations
- Backend stable with 0 failures.
- Some latency spikes observed.
- 95% of requests not under 500ms SLO.
- Next step: review NGINX + MongoDB latency + Prometheus alerts.


