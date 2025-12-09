# K8S Restricted

Under fully restricted there is a caveat:

```log
2024-12-28T02:36:44Z Wrong permissions on /run/chrony
2024-12-28T02:36:44Z Disabled command socket /run/chrony/chronyd.sock
```

To use chronyc, instead use:

```bash
/usr/bin/chronyc -h 127.0.0.1 -p 10323 sources
```

## Metrics

The following metrics are exposed by `chrony_exporter` on port `9433` at `/metrics`.
For more details, see the [chrony_exporter repository](https://github.com/superq/chrony_exporter).

### Tracking Metrics

* **`chrony_tracking_last_offset_seconds`**: The estimated offset of the system clock from the reference time.
* **`chrony_tracking_stratum`**: The stratum of the local clock.
* **`chrony_tracking_root_delay_seconds`**: The total network path delay to the stratum-1 computer.
* **`chrony_tracking_root_dispersion_seconds`**: The maximum error of the local clock relative to the root reference.
* **`chrony_tracking_frequency_ppms`**: The frequency error of the local clock in parts per million (PPM).
* **`chrony_tracking_skew_ppms`**: The estimated error bound on the frequency in PPM.

### Sources Metrics

* **`chrony_sources_state_info`**: Information about the state of each source.
* **`chrony_sources_last_sample_offset_seconds`**: The offset of the last sample measured from this source.
* **`chrony_sources_reachability_ratio`**: The ratio of successful packet exchanges with the source.
* **`chrony_sources_stratum`**: The stratum reported by the remote source.

### Server Statistics Metrics

* **`chrony_serverstats_ntp_packets_received_total`**: The total number of valid NTP requests received.
* **`chrony_serverstats_ntp_packets_dropped_total`**: The number of NTP requests dropped due to rate limiting.
* **`chrony_serverstats_command_packets_received_total`**: The number of command requests received.

