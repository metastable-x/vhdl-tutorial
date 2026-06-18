# UART TX

**Video:** [VHDL Tutorial — UART: TX](https://www.youtube.com/watch?v=rmKMLVji--s&t=56s)

## Project Summary

For this video, we test our UART understanding specifcally by building a transmitter. This is done by sending a single character to a PuTTY terminal. Later we add a controller so that we can send entire messages with our transmitter.

### Files

| File | Description |
|------|-------------|
| `uart_top.vhd` | Top level file for our UART TX system |
| `uart_tx.vhd` | Transmitter block for UART |
| `uart_ctrl.vhd` | UART controller which determines what's sent over the transmitter |
| `uart.xdc` | Basys3 constraint file for UART TX |

> **Note:** Be sure to add `btn_debounce.vhd` from `../../db/` as its required for bitstream generation.

## Edits Made

| Date | Change | Reason |
|------|--------|--------|
| 5/12/26 | `tx_ptr <= MSG_MAX;` added to reset conditions to `uart_ctrl.vhd` | If we reset our system in the middle of transmission we'll mess up our message. Though unlikely, this change removes an edge case error.|
| 6/17/26 | `msg_ascii` changed | The message was changed to match the original implementation. A comment was added for clarity as well.|
