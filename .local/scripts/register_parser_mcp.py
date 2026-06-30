#!/usr/bin/env python3
import os
import sys
import pandas as pd
from pypdf import PdfReader
from mcp.server.fastmcp import FastMCP

# Initialize FastMCP server
mcp = FastMCP("RegisterParser")

@mcp.tool()
def read_pdf_page(pdf_path: str, page_num: int) -> str:
    """
    Reads text content from a specific page of a local PDF document.
    page_num is 1-indexed.
    """
    if not os.path.exists(pdf_path):
        return f"Error: File not found at {pdf_path}"
    
    try:
        reader = PdfReader(pdf_path)
        total_pages = len(reader.pages)
        if page_num < 1 or page_num > total_pages:
            return f"Error: Page number {page_num} out of bounds (Total pages: {total_pages})"
        
        page = reader.pages[page_num - 1]
        text = page.extract_text()
        return text if text else "(No text extracted from this page)"
    except Exception as e:
        return f"Error reading PDF: {str(e)}"

@mcp.tool()
def search_pdf(pdf_path: str, query: str) -> str:
    """
    Searches for a keyword or query term in a local PDF document.
    Returns a list of page numbers (1-indexed) where the query is found.
    """
    if not os.path.exists(pdf_path):
        return f"Error: File not found at {pdf_path}"
    
    try:
        reader = PdfReader(pdf_path)
        matching_pages = []
        for idx, page in enumerate(reader.pages):
            text = page.extract_text()
            if text and query.lower() in text.lower():
                matching_pages.append(idx + 1)
        
        if matching_pages:
            return f"Query '{query}' found on pages: {', '.join(map(str, matching_pages))}"
        else:
            return f"Query '{query}' not found in the document."
    except Exception as e:
        return f"Error searching PDF: {str(e)}"

@mcp.tool()
def read_excel_sheet(excel_path: str, sheet_name: str = None) -> str:
    """
    Reads a sheet from a local Excel (.xlsx, .xls) file and converts it to a Markdown table.
    If sheet_name is None, it reads the first sheet.
    """
    if not os.path.exists(excel_path):
        return f"Error: File not found at {excel_path}"
    
    try:
        xls = pd.ExcelFile(excel_path)
        available_sheets = xls.sheet_names
        
        if sheet_name is None:
            sheet_name = available_sheets[0]
        elif sheet_name not in available_sheets:
            return f"Error: Sheet '{sheet_name}' not found. Available sheets: {', '.join(available_sheets)}"
        
        df = pd.read_excel(excel_path, sheet_name=sheet_name)
        # Drop completely empty rows and columns to clean up the output
        df = df.dropna(how='all').dropna(axis=1, how='all')
        return df.to_markdown(index=False)
    except Exception as e:
        return f"Error reading Excel: {str(e)}"

@mcp.tool()
def list_excel_sheets(excel_path: str) -> str:
    """
    Lists all sheet names available inside a local Excel file.
    """
    if not os.path.exists(excel_path):
        return f"Error: File not found at {excel_path}"
    
    try:
        xls = pd.ExcelFile(excel_path)
        return f"Sheets inside '{os.path.basename(excel_path)}': {', '.join(xls.sheet_names)}"
    except Exception as e:
        return f"Error reading Excel sheets: {str(e)}"

if __name__ == "__main__":
    mcp.run()
