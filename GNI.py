import customtkinter
import tkinter
from tkinter import *
from numpy import pi
from math import sqrt
from numpy import random
import numpy as np
from tkinter.filedialog import asksaveasfile
import os , sys


customtkinter.set_appearance_mode("Dark")  # Modes: "System" (standard), "Dark", "Light"
customtkinter.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"

class leftFrame(customtkinter.CTkFrame):
    def __init__(self, master):
        super().__init__(master)

        self.checkbox_1 = customtkinter.CTkCheckBox(self, text="Hessian")
        self.checkbox_1.grid(row=0, column=0, padx=10, pady=(10, 0), sticky="w")
        self.checkbox_2 = customtkinter.CTkCheckBox(self, text="EignVector")
        self.checkbox_2.grid(row=1, column=0, padx=10, pady=(10, 0), sticky="w")
        self.checkbox_3 = customtkinter.CTkCheckBox(self, text="EignValue")
        self.checkbox_3.grid(row=2, column=0, padx=10, pady=(10, 0), sticky="w")
        self.checkbox_4 = customtkinter.CTkCheckBox(self, text="Scatter")
        self.checkbox_4.grid(row=3, column=0, padx=10, pady=(10, 0), sticky="w")


class rightFrame(customtkinter.CTkFrame):
    def __init__(self, master):
        super().__init__(master)

        self.hexagon = customtkinter.CTkLabel(master=self , text="  Number  of hexagons \n in the base"  )
        self.hexagon.grid(row=0 ,column=0, padx=10, pady=10, sticky="nsew" )
        
        self.N = customtkinter.CTkTextbox(master=self)
        self.N.grid(row=0 , column=1 , padx=10, pady=5)
        self.N.configure(width = 60, height = 20 )
        self.N.insert("0.0", "3")
        
        self.remove = customtkinter.CTkLabel(master=self , text="Remove"  )
        self.remove.grid(row=1 ,column=0, padx=10, pady=10,columnspan=2, sticky="nsew" )
        
        self.left = customtkinter.CTkLabel(master=self , text="Left"  )
        self.left.grid(row=2 ,column=0, padx=2, pady=5, sticky="nsew" )
        
        
        self.l = customtkinter.CTkTextbox(master=self)
        self.l.grid(row=2 , column=1 , padx=10, pady=5)
        self.l.configure(width = 60, height = 20 )
        self.l.insert("0.0", "0")
        
        
        self.top = customtkinter.CTkLabel(master=self , text="Top"  )
        self.top.grid(row=3 ,column=0, padx=2, pady=5, sticky="nsew" )
        
        
        
        self.t = customtkinter.CTkTextbox(master=self)
        self.t.grid(row=3 , column=1 , padx=10, pady=5)
        self.t.configure(width = 60, height = 20 )
        self.t.insert("0.0", "0")
        
        self.right = customtkinter.CTkLabel(master=self , text="Right"  )
        self.right.grid(row=4 ,column=0, padx=2, pady=5, sticky="nsew" )
        
        
            
        self.r = customtkinter.CTkTextbox(master=self)
        self.r.grid(row=4 , column=1 , padx=10, pady=5)
        self.r.configure(width = 60, height = 20 )
        self.r.insert("0.0", "0")


        self.beta = customtkinter.CTkLabel(master=self , text="Beta"  )
        self.beta.grid(row=5 ,column=0, padx=10, pady=10,columnspan=2, sticky="nsew" )
        
        self.beta = customtkinter.CTkTextbox(master=self)
        self.beta.grid(row=6 , column=0 , padx=10, pady=5,columnspan=2)
        self.beta.configure(width = 60, height = 20 )
        self.beta.insert("0.0", "2")
        


class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()

        self.title("GNI (Graphene Nanoisland)")
        self.geometry("400x390")
        self.minsize(400, 390)
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(0, weight=1)

        self.leftframe = leftFrame(self)
        self.leftframe.grid(row=0, column=1, padx=10, pady=(10, 10), sticky="nsw")
        
        self.rightframe = rightFrame(self)
        self.rightframe.grid(row=0, column=0, padx=10, pady=(10, 10), sticky="nsw")

        self.button = customtkinter.CTkButton(self, command=self.print_number, text="Run")
        self.button.grid(row=1, column=0, padx=10, pady=10,columnspan=2, sticky="ew")
        
    def print_number(self):
        N    = " -N_HEXA " + self.rightframe.N.get("0.0", "end-1c")
        l    =  " -l "     + self.rightframe.l.get("0.0", "end-1c")
        t    =  " -t "     + self.rightframe.t.get("0.0", "end-1c")
        r    =  " -r "     + self.rightframe.r.get("0.0", "end-1c")
        beta =  " -Beta "   + self.rightframe.beta.get("0.0", "end-1c")
        
        H    = self.leftframe.checkbox_1.get()
        if (H != 0 ): 
            H = ' -H'
        else:
            H = ''

        Eve    = self.leftframe.checkbox_2.get()
        if (Eve != 0 ): 
            Eve = ' -OR'
        else:
            Eve = ''
        
        Ev    = self.leftframe.checkbox_3.get()
        if (Ev != 0 ): 
            Ev = ' -EV'
        else:
            Ev = ''
            
        P    = self.leftframe.checkbox_4.get()
        if (P != 0 ): 
            P = ' -p'
        else:
            P = ''    
        
        coma = './GNI '+N+l+t+r+beta+H+Eve+Ev+P 
        
        os.system(coma)

    
        
        
        
if __name__ == "__main__":
    app = App()
    app.mainloop()