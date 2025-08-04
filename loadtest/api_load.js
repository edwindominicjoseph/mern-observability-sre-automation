import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 50,               // 50 virtual users
  duration: '1m',        // Test duration: 1 minute
  thresholds: {
    http_req_failed: ['rate<0.01'],        // <1% error rate
    http_req_duration: ['p(95)<500'],      // 95% of requests < 500ms
  },
};

export default function () {
  const res = http.get('https://api.edwindominicjoseph.store/api/books');

  check(res, {
    'status is 200': (r) => r.status === 200,
  });

  sleep(1);  // simulate user think time
}
