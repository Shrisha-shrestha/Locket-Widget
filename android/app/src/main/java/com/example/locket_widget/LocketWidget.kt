package com.example.locket_widget

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

import com.example.locket_widget.R
import es.antonborri.home_widget.HomeWidgetPlugin

class LocketWidget : AppWidgetProvider() {
    override fun onUpdate(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray,
    ) {
        for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.locket_widget).apply {

                val title = widgetData.getString("headline_title", null)
                setTextViewText(R.id.headline_title, title ?: "No title set")

                val description = widgetData.getString("headline_description", null)
                setTextViewText(R.id.headline_description, description ?: "No description set")
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}