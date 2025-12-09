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

* **`chrony_up`**: Whether the chrony server is up (1 = up, 0 = down).
* **`chrony_tracking_last_offset_seconds`**: Chrony tracking last offset in seconds.
* **`chrony_tracking_rms_offset_seconds`**: Chrony tracking long-term average of the offset.
* **`chrony_tracking_frequency_ppms`**: Rate by which the system's clock would be wrong if chronyd was not correcting it, in PPMs.
* **`chrony_tracking_skew_ppms`**: The estimated error bound on the frequency, in PPMs.
* **`chrony_tracking_residual_frequency_ppms`**: Difference between the frequency suggested by the reference source and the one currently in use.
* **`chrony_tracking_root_delay_seconds`**: Total network path delays to the stratum-1 computer.
* **`chrony_tracking_root_dispersion_seconds`**: Total of all measurement errors to the NTP root.
* **`chrony_tracking_stratum`**: Chrony tracking client stratum.
* **`chrony_tracking_update_interval_seconds`**: Time elapsed since the last measurement from the reference source was processed.
* **`chrony_tracking_info`**: Metric with constant '1' value, labeled with `tracking_name`, `tracking_address`, `tracking_refid`.

### Server Statistics Metrics

* **`chrony_serverstats_ntp_packets_received_total`**: The total number of valid NTP requests received.
* **`chrony_serverstats_ntp_packets_dropped_total`**: The number of NTP requests dropped due to rate limiting.
* **`chrony_serverstats_command_packets_received_total`**: The number of command requests received.

## Grafana Dashboard

A Grafana dashboard is available in `grafana-dashboard.json`. You can import this JSON file into your Grafana instance to visualize the metrics.


