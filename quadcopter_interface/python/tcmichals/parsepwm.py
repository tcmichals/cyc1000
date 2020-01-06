import csv


def main():

    hdr_count = 8
    found_hdr = False
    current_hdr_length = 0
    bits_on = 0

    stream_length = 320
    current_stream_length = 0

    run_length = list()

    with open("pwm.csv", newline="") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:

            if int(row[' sclk']) is 1:

                current_stream_length = current_stream_length + 1
                if current_stream_length == stream_length:
                    print( "number of bits found ", run_length, " length:", len(run_length))
                    found_hdr = False
                    current_hdr_length = 0
                    run_length = list()
                    current_stream_length = 0

                if found_hdr is False and int(row[' sdo']) is 1:
                    current_hdr_length += 1

                    if current_hdr_length == hdr_count:
                        found_hdr = True
                        continue

                if found_hdr is True:
                    current_hdr_length += 1
                    if current_hdr_length > 32:
                        continue

                    if int(row[' sdo']) is 0:
                        run_length.append(0)

                    if int(row[' sdo']) is 1:
                        run_length.append(1)



if __name__ == "__main__":
    main()
    print("done")

