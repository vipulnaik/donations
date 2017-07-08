#!/usr/bin/python3

import argparse
import pandas as pd
import numpy as np
import matplotlib
# Force matplotlib to not use any Xwindows backend.
matplotlib.use('Agg')
import matplotlib.pyplot as plt
# from dateutil.relativedelta import relativedelta

pd.set_option('display.width', 1000)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("csv", type=str, help="the CSV file to graph")
    parser.add_argument("output", type=str, help="the output file")
    parser.add_argument("--log10", action="store_true",
            help="plot log10 of pageviews")
    parser.add_argument("--vertical_lines", action="store_true",
            help="show vertical transition lines in graph")
    parser.add_argument("--plot_kind", type=str, default="line",
            help="plot kind, accepts line, bar, barh, etc.; defaults to line.")
    parser.add_argument("--top", type=int, default=0,
            help="if this is a positive integer, only the top " +
            "TOP columns are plotted")
    parser.add_argument("--label", action="store_true",
            help="label the pages at the bottom of the plot")    
    parser.add_argument("--similarity_matrix", action="store_true",
            help="print the similarity matrix of the columns in the CSV")
    parser.add_argument("--subtract_avg", action="store_true",
            help="subtract the average value of each column before " +
            "producing a similarity matrix; you must select " +
            "--similarity_matrix")
    args = parser.parse_args()

    df = get_df(args.csv, args.top)
    if args.similarity_matrix:
        if args.subtract_avg:
            df = subtract_avg_coord(df)
        print(matrix(df).to_html())
    if args.log10:
        df = np.log10(df)
    do_a_plot(df, args.output, kind=args.plot_kind, legend=args.label)

def get_df(fname, top=0):
    '''
    Take the filepath to the input CSV, fname. Return a Pandas DataFrame of the
    CSV.
    '''
    df = pd.read_csv(fname, sep='|')
    if 'Percentage' in df:
        del df['Percentage']
    if top > 0:
        # df.iloc[-2] is the Total row, and "1:" skips the first item, which is
        # the string "Total".
        top_cols = df.iloc[-1, 1:].sort_values(ascending=False)[:top].index.tolist()
    df = df[:-1]        
    if "Month" in df:
        # 200610 -> "2006-10"
        df['Month'] = pd.to_datetime(df['Month'])
        df = df.set_index('Month')
    else:
        # "Year" must be in df
        df['Year'] = pd.to_datetime(df['Year'].map(lambda x:
            str(x) + "-01-01"))
        df = df.set_index('Year')
    df = df.sort_index()
    if top_cols:
        return df[top_cols]
    return df

def do_a_plot(df, fname, kind, legend=None):
    df.plot(kind=kind, legend=legend)
    # If we want rolling averages, we would set n to whatever the window length
    # is, but for now we don't, so just hard-code it to 1
    # n = 1
    if legend:
        plt.legend(bbox_to_anchor=(0.0, -0.14), loc='upper left', ncol=2)    
    plt.savefig(fname, bbox_inches="tight")
    plt.clf()
    plt.close()

def matrix(df):
    '''
    Calculate and return the matrix representing the similarity of the pages in
    the Pandas DataFrame df. The closer the pages are, the closer the values in
    the matrix will be to 1.
    '''
    cols = df.columns
    res = pd.DataFrame(index=cols, columns=cols)
    for i in df:
        for j in df:
            dot = df[i].dot(df[j])
            inorm = np.sqrt(np.square(df[i]).sum())
            jnorm = np.sqrt(np.square(df[j]).sum())
            res[i][j] = dot/(inorm*jnorm)
    return res

def subtract_avg_coord(df):
    '''
    For each column (x_1, ..., x_n) in the Pandas DataFrame df, transform to
    (x_1 - x, ..., x_n - x), where x = (x_1 + ··· + x_n) / n is the average of
    the coordinates. Return a new transformed DataFrame.
    '''
    res = pd.DataFrame(index=df.index, columns=df.columns)
    for col in df:
        avg = df[col].mean()
        res[col] = df[col] - avg
    return res

if __name__ == "__main__":
    main()
