# LED Tests

**Video:** [VHDL Tutorial — FPGA Hardware: LEDs](https://www.youtube.com/watch?v=smXAsJ4FwgE)

## Project Summary

For this video, we test the onboard LEDs of the Basys3 with four major tests: turning on a single LED, strobing a single LED, sweeping through all LEDs, and using all 16 LEDs to create a binary counter. Originally we only used one vhdl file / constraint file. The vhdl and constraint files have been updated so that the contraint file works with all vhdl tests. 

> **Note:** This folder now contains four top files so you'll have to select the specific test you'd like to run in Vivado in order to get a working bitfile.


### Files

| File | Description |
|------|-------------|
| `led_test_single.vhd` | Top level file for turning on a single LED |
| `led_test_strobe.vhd` | Top level file for a single LED strobe |
| `led_test_sweep.vhd`  | Top level file for an LED sweep using all LEDs |
| `led_test.vhd` | Top level file for a binary counter using all LEDs |
| `led_test.xdc` | Basys3 constraints file for LED tests|


## Edits Made

| Date | Change | Reason |
|------|--------|--------|
| 5/15/26 | All LEDs are connected | All tests can be run with the contraint file |

