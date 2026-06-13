# FIFO (First-In First-Out)

**Video:** [VHDL Tutorial — FIFOs](https://youtu.be/fuWIt8vUuV8?si=c-ig2qucFtxxZ5OF)

## Project Summary

In this video we build a **FIFO** (First-In First-Out). FIFOs allow us to store data when the rest of our system isn't ready to use it. We can implement a FIFO on the Basys3 by using the first 14 switches to select a number in binary. The center button is then pressed to store this value in the FIFO. Pressing the left button will spit out the first value entered in the FIFO and display it on the seven segment display. The FIFO has a depth of 16 but this value can be changed to store more data.

### Files

| File | Description |
|------|-------------|
| `fifo_top.vhd` | Top level file for our FIFO implementation |
| `fifo.vhd` | FIFO module itself |
| `seg_driver.vhd` | 7-segment display driver |
| `fifo_top.xdc` | FIFO constraint file |

> **Note:** Be sure to add `btn_debounce.vhd` from `../db/` as its required for bitstream generation

## Edits Made

| Date | Change | Reason |
|------|--------|--------|
| 5/15/26 | `wr_en` & `rd_en` are now `wr_stb` & `rd_stb` | `stb` means that the data associated is only valid for a single clock cycle. `en` can mean different things to different systems so we've changed it for clarity. |


