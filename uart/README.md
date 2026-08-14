# UART

## Project Summary

This section covers the design of a complete **8N1** (8 data bits / no parity bit / 1 stop bit) UART transceiver on the Basys3. We start with a transmitter, then extend the design to include a receiver, message selection, and 7-segment display. The project is split into several subfolders:

| Folder | Description |
|--------|-------------|
| [`tx/`](./tx/) | UART TX — sends messages over UART to a PuTTY terminal |
| [`rx/`](./rx/) | UART RX — adds RX echo, message selection, and 7-segment display |
| [`parity/`](./parity/) | UART Parity — adds a parity bit, drops bad data, and adds an error counter |
